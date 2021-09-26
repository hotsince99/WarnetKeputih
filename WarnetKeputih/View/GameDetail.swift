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
    var gameId: Int
    
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
                    Image(systemName: "calendar")
                    Text("Release Date: " + apiServices.gameInfo.released)
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.2f", apiServices.gameInfo.rating))
                }
                
                Link("Visit Website", destination: URL(string: apiServices.gameInfo.website)!)
                
                HStack {
                    Text(apiServices.gameInfo.description)
                        .padding()
                }
            }
        }
        .onAppear() {
            self.apiServices.getGameInfo(gameId: gameId)
        }
    }
}
