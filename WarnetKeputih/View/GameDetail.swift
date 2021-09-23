//
//  GameDetail.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI

struct GameDetail: View {
    var game: Game
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 30)
                
                Text(game.name)
                    .font(.system(size: 20))
                    .bold()
                    .lineLimit(2)
                
                Spacer(minLength: 20)
                
                Image(game.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320, height: 250, alignment: .center)
                Spacer(minLength: 20)
                
                HStack {
                    Image(systemName: "calendar")
                    Text("Release Date: " + game.release)
                }
                Spacer(minLength: 20)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.2f", game.rating))
                }
            }
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        GameDetail(game: games[0])
    }
}
