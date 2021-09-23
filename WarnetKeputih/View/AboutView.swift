//
//  AboutView.swift
//  WarnetKeputih
//
//  Created by Josua Hutapea on 23/09/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
     
        NavigationView {
            VStack {
                
                Image("display_picture")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    .cornerRadius(30)
                    .padding(.top, 50)
                    .padding(.bottom)
                
                Text("Josua Margandatua Hutapea")
                    .font(.headline)
                
                Text("ITS Surabaya")
                    .font(.subheadline)
                
                Spacer(minLength: 30)
                
            }.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .navigationBarTitle("About")
        }
            
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
