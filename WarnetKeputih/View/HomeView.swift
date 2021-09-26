//
//  HomeView.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var apiServices = ApiServices()
    
    var body: some View {
        
        NavigationView {
            GameList(games: apiServices.games)
                .onAppear() {
                    self.apiServices.getGames()
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
