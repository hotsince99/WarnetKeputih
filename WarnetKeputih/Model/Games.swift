//
//  Games.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 26/09/21.
//

import Foundation

struct Games: Codable {
    let count: Int
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case count
        case games = "results"
    }
}
