//
//  ContentView.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Catalogue", systemImage: "list.bullet.rectangle")
                }
            AboutView()
                .tabItem {
                    Label("About", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
