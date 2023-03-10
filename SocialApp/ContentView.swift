//
//  ContentView.swift
//  SocialApp
//
//  Created by Danik on 29.12.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = [String]()
    
    @State private var navPath = NavigationNextPageAction().path
    
    let DataPass: String = "Data passed from prev screen"
        
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack(alignment: .center) {
                
                NavigationLink {
                    LoginView(DataPass: DataPass)
                    
                } label: {
                    Text("LOGIN")
                        .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 10)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("")
                
                Button(action: {
                    print("sign up bin tapped")
                }) {
                    Text("SIGN UP")
                        .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 10)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .cornerRadius(25)
                
            }
//            .navigationBarHidden(true)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(
                LinearGradient(gradient: Gradient(colors: [.indigo, .purple]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
