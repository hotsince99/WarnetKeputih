//
//  GameRow.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
    var id: Int
    var name: String
    var backgroundImage: String
    var rating: Float
    var released: String
    
    var body: some View {
        
        GeometryReader { card in
            
            VStack(alignment: .leading) {
                WebImage(url: URL(string: backgroundImage))
                    .resizable()
                    .scaledToFill()
                    .frame(width: card.size.width, height: card.size.height * 0.7 , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
            
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(name)
                            .font(.title2)
                            .bold()
                            .lineLimit(1)
                        
                        HStack {
                            Image(systemName: "calendar")
                            Text(released)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.2f", rating))
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
        GameRow(id: 1,
                name: "GTA V",
                backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
                rating: 4.48,
                released: "2013-09-17")
            .frame(height:370).padding()
    }
}
