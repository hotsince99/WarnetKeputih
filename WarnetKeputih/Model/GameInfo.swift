//
//  GameInfo.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 26/09/21.
//

import UIKit

struct GameInfo: Identifiable, Codable {
    var id: Int32
    var name: String
    var backgroundImage: String
    var rating: Float
    var released: String
    var desc: String
    var website: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case released
        case desc = "description_raw"
        case website
    }
}
