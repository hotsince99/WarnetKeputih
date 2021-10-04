//
//  FavoriteView.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 02/10/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @State var favoriteGames: [GameFavorite] = []
    
    var body: some View {
        NavigationView {
            List(favoriteGames, id: \.id) { selectedGame in
                ZStack {
                    GameRow(id: Int(selectedGame.id ?? 0),
                            name: selectedGame.name ?? "",
                            backgroundImage: selectedGame.backgroundImage ?? "",
                            rating: selectedGame.rating ?? 0.0,
                            released: selectedGame.released ?? "")
                
                    NavigationLink(destination: FavoriteDetailView(id: selectedGame.id!,
                                                                   name: selectedGame.name!,
                                                                   backgroundImage: selectedGame.backgroundImage!,
                                                                   rating: selectedGame.rating!,
                                                                   released: selectedGame.released!,
                                                                   desc: selectedGame.desc!,
                                                                   website: selectedGame.website!)) { }
                }
            }.environment(\.defaultMinListRowHeight, 390)
            .navigationBarTitle("Favorite")
            .onAppear {
                GameProvider().getAllFavoriteGame { favoriteGames in
                    DispatchQueue.main.async {
                        self.favoriteGames = favoriteGames
                    }
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
