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
