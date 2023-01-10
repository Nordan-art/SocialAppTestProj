//
//  SearchSreen.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import SwiftUI

struct SearchSreen: View {
    var BoundWidth = UIScreen.main.bounds.size.width
    var BoundHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            ForEach(0..<100) { item in
                
                VStack(spacing: 20) {
                    Text("BoundWidth: \(BoundWidth)")
                    Text("BoundHeight: \(BoundHeight)")
                    Text("Item \(item)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                .frame(width: BoundWidth - 20, height: 200)
                .background(.red)
                .cornerRadius(15)
            }
            .padding(.top, 30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
//        .background(
//            LinearGradient(gradient: Gradient(colors: [.indigo, .purple]), startPoint: .top, endPoint: .bottom)
//        )
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchSreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchSreen()
    }
}
