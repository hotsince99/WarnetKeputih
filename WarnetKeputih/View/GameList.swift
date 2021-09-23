//
//  GameList.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI

struct GameList: View {
    var body: some View {
        List(games) { selectedGame in
            ZStack {
                GameRow(game: selectedGame)
                NavigationLink(destination: GameDetail(game: selectedGame)) { }
            }
        }.environment(\.defaultMinListRowHeight, 390)
        .navigationBarTitle("Catalogue")
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        GameList()
    }
}
