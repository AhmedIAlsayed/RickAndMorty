//
//  Character.swift
//  Domain
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation

public struct Character {
    public let id: String
    public let imageURLString: String
    public let title: String
    public let subtitle: String
    
    public init(
        id: String,
        imageURLString: String,
        title: String,
        subtitle: String
    ) {
        self.id = id
        self.imageURLString = imageURLString
        self.title = title
        self.subtitle = subtitle
    }
}
