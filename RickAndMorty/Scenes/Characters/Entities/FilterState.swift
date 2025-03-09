//
//  FilterState.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

enum FilterState: String, CaseIterable {
    case human = "Human"
    case iOSEngineer = "iOS Engineer"
    case animal = "Animal"
    case plant = "Plant?"
    case robot = "Robot"
    case automobiles = "Cars"
    case unknown = "unknown"
    
    var title: String {
        switch self {
        case .human:
            "Human 👨🏼‍🦯"
        case .iOSEngineer:
            "iOS Engineer 🧟‍♂️"
        case .animal:
            "Animal 🦦"
        case .plant:
            "Plant? 🌱"
        case .robot:
            "Robot 🤖"
        case .automobiles:
            "Cars 🚗"
        case .unknown:
            "unknown 💭"
        }
    }
}
