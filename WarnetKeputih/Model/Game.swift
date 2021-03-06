//
//  Game.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import UIKit

struct Game: Identifiable, Codable {
    var id: Int
    var name: String
    var backgroundImage: String
    var rating: Float
    var released: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case released
    }
}
