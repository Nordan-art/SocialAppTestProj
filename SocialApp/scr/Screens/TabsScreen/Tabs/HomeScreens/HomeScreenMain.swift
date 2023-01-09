//
//  HomeScreenMain.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import SwiftUI

struct HomeScreenMain: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Home screen")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
//ProfileScreen
//SearchSreen

struct HomeScreenMain_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenMain()
    }
}
