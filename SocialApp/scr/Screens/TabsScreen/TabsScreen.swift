//
//  TabsScreen.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import SwiftUI

struct TabsScreen: View {
    
    
    
    var body: some View {
        ZStack {
            TabView {
                
                HomeScreenMain()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                ProfileScreen()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                SearchSreen()
                    .tabItem {
                        Label("Order", systemImage: "square.and.pencil")
                    }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabsScreen()
    }
}
