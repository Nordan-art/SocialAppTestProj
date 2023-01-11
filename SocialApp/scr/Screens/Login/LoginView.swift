//
//  LoginView.swift
//  SocialApp
//
//  Created by Danik on 29.12.22.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var path = [String]()
    @State private var navPath = NavigationNextPageAction().path
    
    @State var DataPass: String
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
//            Text("\(DataPass)")
            
//            MARK: - NameTextField
            TextField("Name", text: $email)
                            .textFieldStyle(
                                GradientTextFieldBackground(
                                    systemImageString: "envelope"
                                )
                            )
                            .frame(minWidth: 100, maxWidth: 250)
                            .padding(.bottom, 20)
            
//            MARK: - EmailTextField
            TextField("Email", text: $password)
                            .textFieldStyle(
                                GradientTextFieldBackground(
                                    systemImageString: "lock"
                                )
                            )
                            .frame(minWidth: 100, maxWidth: 250)
                            .padding(.bottom, 20)
            
//            Button(action: {
//                HomeScreenMain()
//            }) {
//                Text("Login")
//                    .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 10)
//                    .font(.system(size: 18))
//                    .padding()
//                    .foregroundColor(.white)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.white, lineWidth: 2)
//                    )
//            }
//            .cornerRadius(25)
            
//            NavigationLink {
//                SendLoginData()
////                TabsScreen()
//            } label: {
//                Text("LOGIN")
//                    .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 10)
//                    .font(.system(size: 18))
//                    .padding()
//                    .foregroundColor(.white)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.white, lineWidth: 1)
//                    )
//            }
//            .navigationBarBackButtonHidden(false)
//            .navigationTitle("")
            
            Button(action: {
                SendLoginData()
            }) {
                Text("LOGIN")
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
            
            Button(action: {
                dismiss()
            }) {
                Text("Return")
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
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(
            LinearGradient(gradient: Gradient(colors: [.indigo, .purple]), startPoint: .top, endPoint: .bottom)
        )
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
