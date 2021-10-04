//
//  FavoriteDetailView.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 05/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteDetailView: View {
    var id: Int32
    var name: String
    var backgroundImage: String
    var rating: Float
    var released: String
    var desc: String
    var website: String
    
    var gameProvider = GameProvider()
    @State var gameIsFavorite: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing:10) {
                Spacer(minLength: 10)
                
                Text(name)
                    .font(.title)
                    .bold()
                    .lineLimit(2)
                
                WebImage(url: URL(string: backgroundImage))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 360, height: 250, alignment: .center)
                    .cornerRadius(20)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Release Date: " + released)
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.2f", rating))
                        }
                    }
                    .padding()
                    
                    Button{
                        
                        if (!gameIsFavorite) {
                            gameIsFavorite.toggle()
                            gameProvider.addGameToFavorite(
                                id,
                                name,
                                backgroundImage,
                                rating,
                                released,
                                desc,
                                website) { }
                        } else {
                            gameIsFavorite.toggle()
                            gameProvider.removeGameFromFavorite(Int(id)) { }
                        }
                    } label: {
                        Image(systemName: gameIsFavorite ? "heart.fill" : "heart" )
                            .foregroundColor(.pink)
                    }
                    .padding(30)
                }
                
                Link("Visit Website", destination: URL(string: website)!)
                
                HStack {
                    Text(desc)
                        .padding()
                }
            }
        }
        .onAppear() {
            self.gameProvider.isFavorite(gameId: Int(id)) { isFavorite in
                gameIsFavorite = isFavorite
            }
        }
    }
}

struct FavoriteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDetailView(id: 1,
                           name: "GTA V",
                           backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
                           rating: 4.48,
                           released: "2013-09-17",
                           desc: "Lorem Ipsum dolor sit amet",
                           website: "https://www.rockstargames/v/")
    }
}
