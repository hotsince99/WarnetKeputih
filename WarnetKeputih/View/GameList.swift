//
//  GameList.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI

struct GameList: View {
    
    var games: [Game]
    
    var body: some View {
        List(games, id: \.id) { selectedGame in
            ZStack {
                GameRow(id: selectedGame.id,
                        name: selectedGame.name,
                        backgroundImage: selectedGame.backgroundImage,
                        rating: selectedGame.rating,
                        released: selectedGame.released)
                NavigationLink(destination: GameDetail(gameId: selectedGame.id)) { }
            }
        }.environment(\.defaultMinListRowHeight, 390)
        .navigationBarTitle("Catalogue")
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        GameList(games: dummyGames)
    }
}
