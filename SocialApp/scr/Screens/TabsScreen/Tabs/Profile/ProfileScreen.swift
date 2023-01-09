//
//  ProfileScreen.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        ZStack {
            VStack {
                List {
                    Text("ProfileScreen")
                        .frame(height: 500)
                        .navigationTitle("Home")
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .background( .white)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
