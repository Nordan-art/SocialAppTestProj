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
            
            ForEach(0..<10) { item in
                VStack(spacing: 20) {
                    Text("BoundWidth \(BoundWidth)")
                    Text("BoundHeight \(BoundHeight)")
                    Text("Item \(item)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                .frame(width: BoundWidth - 20, height: 200)
                .background(.red)
                .cornerRadius(15)
            }
            .padding(.top, 30)
            
//            VStack(spacing: 20) {
//                ForEach(0..<10) {
//                    Text("BoundWidth \(BoundWidth)")
//                    Text("BoundHeight \(BoundHeight)")
//                    Text("Item \($0)")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
////                        .frame(width: BoundWidth - 20, height: 200)
////                        .background(.red)
////                        .cornerRadius(15)
//                }
//            }
//            .frame(width: BoundWidth - 20, height: 200)
//            .background(.red)
//            .cornerRadius(15)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchSreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchSreen()
    }
}
