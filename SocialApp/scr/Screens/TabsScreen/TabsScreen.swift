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
                
                Group {
                    
                    HomeScreenMain()
                        .tabItem {
                            Label("", systemImage: "house.fill")
                        }
                    
                    SearchSreen()
                        .tabItem {
                            Label("", systemImage: "square.and.pencil")
                        }
                    
                    ProfileScreen()
                        .tabItem {
                            Label("", systemImage: "person.circle.fill")
                        }
                        .badge(3)
                }
                .toolbarColorScheme(.dark, for: .tabBar)
//                .toolbar(.visible, for: .tabBar)
//                   .toolbarBackground(Color.yellow, for: .tabBar)


            }
//            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
//            .toolbarBackground(.red, for: .tabBar)
        }
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                VStack {
//                    Text("Yellow And Bold Title")
//                        .bold()
//                        .foregroundColor(.yellow)
//                }
//            }
//        }
//        .toolbar {
//                    ToolbarItem(placement: .principal) {
//                        HStack {
//                            Image(systemName: "sun.min.fill")
//                            Text("Title")
//                                .font(.headline)
//                                .foregroundColor(.orange)
//                        }
//                    }
//                }
        .safeAreaInset(edge: .top, alignment: .center, spacing: 45) {
                        Color.clear
                            .frame(height: 20)
                            .background(Material.bar)
                    }
//        .safeAreaInset(edge: .top) {
//                Text("Outside Safe Area")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(.indigo)
//            }
//        .toolbarBackground(.red, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
    }
}

struct TabsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabsScreen()
    }
}
