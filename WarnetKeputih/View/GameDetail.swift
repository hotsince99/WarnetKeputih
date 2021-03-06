//
//  GameDetail.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetail: View {
    
    @ObservedObject var apiServices = ApiServices()
    var gameProvider = GameProvider()
    var gameId: Int
    @State var gameIsFavorite: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing:10) {
                Spacer(minLength: 10)
                
                Text(apiServices.gameInfo.name)
                    .font(.title)
                    .bold()
                    .lineLimit(2)
                
                WebImage(url: URL(string: apiServices.gameInfo.backgroundImage))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 360, height: 250, alignment: .center)
                    .cornerRadius(20)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Release Date: " + apiServices.gameInfo.released)
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.2f", apiServices.gameInfo.rating))
                        }
                    }
                    .padding()
                    
                    Button{
                        
                        if (!gameIsFavorite) {
                            gameIsFavorite.toggle()
                            gameProvider.addGameToFavorite(
                                apiServices.gameInfo.id,
                                apiServices.gameInfo.name,
                                apiServices.gameInfo.backgroundImage,
                                apiServices.gameInfo.rating,
                                apiServices.gameInfo.released,
                                apiServices.gameInfo.desc,
                                apiServices.gameInfo.website) { }
                        } else {
                            gameIsFavorite.toggle()
                            gameProvider.removeGameFromFavorite(
                                Int(apiServices.gameInfo.id)) { }
                        }
                    } label: {
                        Image(systemName: gameIsFavorite ? "heart.fill" : "heart" )
                            .foregroundColor(.pink)
                    }
                    .padding(30)
                }
                
                Link("Visit Website", destination: URL(string: apiServices.gameInfo.website)!)
                
                HStack {
                    Text(apiServices.gameInfo.desc)
                        .padding()
                }
            }
        }
        .onAppear() {
            self.apiServices.getGameInfo(gameId: gameId)
            self.gameProvider.isFavorite(gameId: gameId) { isFavorite in
                gameIsFavorite = isFavorite
            }
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        GameDetail(gameId: 3498)
    }
}
