//
//  LoginView.swift
//  SocialApp
//
//  Created by Danik on 29.12.22.
//

import SwiftUI

struct LoginView: View {
    
    @State var DataPass: String
    
    var body: some View {
        
        Text("This is login View")
        Text("\(DataPass)")
        
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
