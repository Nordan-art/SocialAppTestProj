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
    
    var url: NSURL = NSURL(string: "http://crm.mcgroup.pl/mcgroup_crmAPI/alfa/task?id=23&item=consultM&price=100")!
    
    var body: some View {
        VStack(alignment: .center) {
//            Text("\(DataPass)")
            
//            MARK: - NameTextField
            TextField("login", text: $email)
                            .textFieldStyle(
                                GradientTextFieldBackground(
                                    systemImageString: "envelope"
                                )
                            )
                            .frame(minWidth: 100, maxWidth: 250)
                            .padding(.bottom, 20)
            
//            MARK: - EmailTextField
            TextField("pass", text: $password)
                            .textFieldStyle(
                                GradientTextFieldBackground(
                                    systemImageString: "lock"
                                )
                            )
                            .frame(minWidth: 100, maxWidth: 250)
                            .padding(.bottom, 20)
            
            NavigationLink {
                            TabsScreen()
                        } label: {
                            Text("NavLogin")
                                .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 10)
                                .font(.system(size: 18))
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                        .navigationBarBackButtonHidden(false)
                        .navigationTitle("")
            
            Button(action: {
                SendLoginData()
            }) {
                Text("Get notif")
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
                CustomApi()
            }) {
                Text("CustomApi")
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
//                dismiss()
//                print("current time: \(Int(Date().timeIntervalSince1970))")
//                print("current time add 1 hour: \(Int(Date().timeIntervalSince1970 + 3_600_000))")
                let startTime = Date.now
                let endTime = startTime.adding(hours: 1)
                print("startTime \(Int(startTime.timeIntervalSince1970))")
                print("endTime \(Int(endTime.timeIntervalSince1970))")
                print(url.query!)
                print(url.query!.components(separatedBy: "&") )
                let components = url.query!.components(separatedBy: "&")
                for item in components {
                    if (item.components(separatedBy: "=")[0] == "id") {
                        print(item.components(separatedBy: "=")[1] )
                    }
                    if (item.components(separatedBy: "=")[0] == "price") {
                        print(item.components(separatedBy: "=")[1] )
                    }
                    if (item.components(separatedBy: "=")[0] == "item") {
                        print(item.components(separatedBy: "=")[1] )
                    }
                    
                }
            }) {
                Text("Sign up")
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

extension Date {
    func adding(minutes: Int) -> Date {
        Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    func adding(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
