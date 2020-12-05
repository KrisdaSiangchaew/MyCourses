//
//  Award.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 5/12/2563 BE.
//

import Foundation

struct Award: Decodable, Identifiable {
    var id: String { name }
    
    let name: String
    let description: String
    let color: String
    let criterion: String
    let value: Int
    let image: String
    
    static let allAwards: [Award] =
        Bundle.main.decode([Award].self, from: "Awards.json")
    
    static let example: Award = allAwards[0]
}
