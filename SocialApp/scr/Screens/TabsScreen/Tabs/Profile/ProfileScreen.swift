//
//  ProfileScreen.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import SwiftUI
import StoreKit

//public enum PurchaseResult {
//    case success(VerificationResult<Transaction>)
//    case userCancelled
//    case pending
//}
//
//public enum VerificationResult<SignedType> {
//    case unverified(SignedType, VerificationResult<SignedType>.VerificationError)
//    case verified(SignedType)
//}

struct ProfileScreen: View {
    var BoundWidth = UIScreen.main.bounds.size.width
    var BoundHeight = UIScreen.main.bounds.size.height
    
    @EnvironmentObject
     var purchaseManager: PurchaseManager
    
    var body: some View {
        ZStack {
            VStack {
                
                if purchaseManager.hasUnlockedPro {
                            Text("Thank you for purchasing pro!")
                        .padding(.top, 60)
                } else {
                    List {
                        Text("ProfileScreen product")
                            .navigationTitle("Home")
                        ForEach(purchaseManager.products) { product in
                            Button {
                                Task {
                                    do {
                                        try await purchaseManager.purchase(product)
                                    } catch {
                                        print(error)
                                    }
                                }
                            } label: {
                                Text("\(product.displayPrice) - \(product.displayName)")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                    }.task {
                        do {
                            print("loadProducts")
                            try await purchaseManager.loadProducts()
                        } catch {
                            print(error)
                        }
                    }
                }
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .background( .white)
            .padding(.top, 30)
        }
//        .frame(width: BoundWidth - 20, height: 200)
//        .background(.red)
//        .cornerRadius(15)
        .navigationBarBackButtonHidden(true)
        .task {
            Task {
                do {
                    try await purchaseManager.loadProducts()
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
