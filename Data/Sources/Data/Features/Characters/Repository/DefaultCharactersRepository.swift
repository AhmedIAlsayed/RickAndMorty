//
//  File.swift
//  Data
//
//  Created by Ahmed on 07/03/2025.
//

import Domain

public class DefaultCharactersRepository: CharactersRepository {
    
    public init() { }
    
    public func fetchCharacters(for page: Int) async throws -> [Domain.Character] {
        return [
            Character(id: "", imageURLString: "", title: "Adlskfds", subtitle: "ryt"),
            Character(id: "", imageURLString: "", title: "fsdfdsf", subtitle: "iuy"),
            Character(id: "", imageURLString: "", title: "kjhhj", subtitle: "dsfsdfsd"),
            Character(id: "", imageURLString: "", title: "khjjh", subtitle: "ryueyt"),
            Character(id: "", imageURLString: "", title: "hdgffgh", subtitle: "urteu"),
            Character(id: "", imageURLString: "", title: "hfghfg", subtitle: "gasdg"),
            Character(id: "", imageURLString: "", title: "rwerw", subtitle: "fsgd"),
            Character(id: "", imageURLString: "", title: "cbvcv", subtitle: "fdsfds"),
            Character(id: "", imageURLString: "", title: "645gf", subtitle: "gg"),
            Character(id: "", imageURLString: "", title: "rujer", subtitle: "jgh"),
            Character(id: "", imageURLString: "", title: "hgfdfg", subtitle: "gweg"),
            Character(id: "", imageURLString: "", title: "iyuiy", subtitle: "hfghgf"),
            Character(id: "", imageURLString: "", title: "KLDFS", subtitle: "sdg"),
            Character(id: "", imageURLString: "", title: "gfhfg", subtitle: "DV"),
            Character(id: "", imageURLString: "", title: "OIU", subtitle: "oiu"),
            Character(id: "", imageURLString: "", title: "tykr", subtitle: "LUI"),
        ]
    }
}
