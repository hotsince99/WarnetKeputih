//
//  GameRow.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI

struct GameRow: View {
    var game: Game
    
    var body: some View {
        
        GeometryReader { card in
            
            VStack(alignment: .leading) {
                Image(game.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: card.size.width, height: card.size.height * 0.7 , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
            
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(game.name)
                            .font(.title2)
                            .bold()
                            .lineLimit(1)
                        
                        HStack {
                            Image(systemName: "calendar")
                            Text(game.release)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.2f", game.rating))
                                .font(.subheadline)
                        }
                    }
                }.padding(.horizontal)
            
            }.padding(.bottom)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray)
            )
            .shadow(radius: 2)
            
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: games[0]).frame(height:370).padding()
        //GameRow(game: games[1]).previewLayout(.fixed(width: 320, height: 350))
    }
}
