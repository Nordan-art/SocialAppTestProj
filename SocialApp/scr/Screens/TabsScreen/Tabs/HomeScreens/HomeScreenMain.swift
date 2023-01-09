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
                List {
                    
                    Text("Home")
                    
//                        .frame(height: 500)
                    
                    Text("Test1")
                       
                    Text("Test2")
                        
                    Text("Test3")
                    
                    Text("Test4")
                    
                    Text("Test5")
                        
                }
               
            }
            .padding(.top, 60)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            
        }
        .navigationBarBackButtonHidden(false)
    }
}

struct HomeScreenMain_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenMain()
    }
}
