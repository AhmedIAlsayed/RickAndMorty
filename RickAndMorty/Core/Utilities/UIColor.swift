//
//  UIColor.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import UIKit

func randomColor() -> UIColor {
    return UIColor(
        hue: .random(in: 0...1),
        saturation: 0.4,
        brightness: 0.8,
        alpha: 0.3
    )
}
