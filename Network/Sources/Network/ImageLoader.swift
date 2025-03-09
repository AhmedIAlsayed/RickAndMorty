//
//  ImageLoader.swift
//  Network
//
//  Created by Ahmed on 09/03/2025.
//

import Foundation
import UIKit

public protocol ImageLoader {
    func load(image urlString: String, completion: @escaping (UIImage?) -> Void)
    func cancel(request urlString: String)
}

public final class DefaultImageLoader: ImageLoader {
    
    // MARK: Private Properties
    
    /// The currently active networking requests, identified with the key of their `URL` string.
    ///
    private var runningTasks: [String: URLSessionDataTask] = [:]
    
    private var cachedImages: NSCache<NSString, UIImage> = .init()
    
    /// This is a locking mechanism to ensure any reading and writing
    /// operations for the `runningTasks` happen in a `thread-safe` manner.
    ///
    private let runningTasksQueue = DispatchQueue(label: "com.queue.runningTasks")
    
    // MARK: Constructor
    
    private init() { }
    
    public static let shared: DefaultImageLoader = .init()
    
    // MARK: Public Interfaces
    
    public func load(
        image urlString: String,
        completion: @escaping (UIImage?) -> Void
    ) {
        /// We make sure to check our cached layer before performing a costly operation of fetching an image over the network.
        ///
        if let image = cachedImages.object(forKey: urlString as NSString) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession
            .shared
            .dataTask(
                with: URLRequest(url: url),
                completionHandler: { [weak self] (data, _, _) in
                    guard let self else { return }
                    
                    /// A request has finished, so we clean up the dictionary holding a reference to this request.
                    ///
                    runningTasksQueue.async(flags: .barrier) {
                        self.runningTasks.removeValue(forKey: url.absoluteString)
                    }
                    
                    guard let data, let image = UIImage(data: data) else {
                        /// Error states will be modeled as `nil` for simplicity, since I don't care for any specific image requests errors.
                        /// In the case of a completion with a nullable object, we can simply add a `placeholder-image`.
                        ///
                        DispatchQueue.main.async { completion(nil) }
                        return
                    }
                    
                    DispatchQueue.main.async { completion(image) }
                    
                    cachedImages.setObject(image, forKey: url.absoluteString as NSString)
                }
            )
        
        runningTasksQueue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            
            self.runningTasks[url.absoluteString] = task
        }
        
        task.resume()
    }
    
    public func cancel(request urlString: String) {
        runningTasksQueue.async(flags: .barrier) { [weak self] in
            guard let self else { return }
            
            self.runningTasks[urlString]?.cancel()
            self.runningTasks.removeValue(forKey: urlString)
        }
    }
}
