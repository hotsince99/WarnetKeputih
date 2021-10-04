//
//  ApiServices.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 26/09/21.
//

import Foundation
import SwiftUI

class ApiServices: ObservableObject {
    
    @Published var games: [Game] = []
    @Published var gameInfo = GameInfo(id: 0, name: "", backgroundImage: "", rating: 0.0, released: "", desc: "", website: "http://")
    
    private let apiKey = "cd6007daf1e44a308a182eb724560f8d"
    
    func getGames() {
        let pageSize = "10"
        
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "page_size", value: pageSize)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    self.games = []
                }
                return
            }
            
            if response.statusCode == 200 {
                let decoder = JSONDecoder()
                if let listOfGames = try? decoder.decode(Games.self, from: data) as Games {
                    DispatchQueue.main.async {
                        self.games = listOfGames.games
                    }
                } else {
                    print("ERROR: Can't Decode JSON")
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        task.resume()
    }
    
    func getGameInfo(gameId: Int) {
        var components = URLComponents(string: "https://api.rawg.io/api/games/\(gameId)")!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
        ]
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    self.gameInfo = GameInfo(id: 0, name: "", backgroundImage: "", rating: 0.0, released: "", desc: "", website: "")
                }
                return
            }
            
            if response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                if let gameInfoFromAPI = try? decoder.decode(GameInfo.self, from: data) as GameInfo {
                    DispatchQueue.main.async {
                        self.gameInfo = gameInfoFromAPI
                    }
                } else {
                    print("ERROR: Can't Decode JSON")
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        task.resume()
    }
}


