//
//  LoginInputStyle.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import Foundation
import SwiftUI

struct GradientTextFieldBackground: TextFieldStyle {
    
    let systemImageString: String
    
    // Hidden function to conform to this protocol
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(
//                    LinearGradient(
//                        colors: [
//                            .red,
//                            .blue
//                        ],
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
                    LinearGradient(
                        colors: [
                            .white,
                            .white
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 40)
            
            HStack {
                Image(systemName: systemImageString)
                // Reference the TextField here
                configuration
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
}
