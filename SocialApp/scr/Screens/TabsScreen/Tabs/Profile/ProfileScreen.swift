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
    var url: NSURL = NSURL(string: "http://crm.mcgroup.pl/mcgroup_crmAPI/alfa/task?id=23&item=consultM&price=100")!
    var BoundWidth = UIScreen.main.bounds.size.width
    var BoundHeight = UIScreen.main.bounds.size.height
    
    @EnvironmentObject
    private var entitlementManager: EntitlementManager
    
    @EnvironmentObject
    private var purchaseManager: PurchaseManager
    
    var body: some View {
        
        //        ForEach(purchaseManager.purchasedProducts) { item in
        //        }
        //        ForEach(purchaseManager.purchasedProducts) {  }
        
        List {
            Text("ProfileScreen product")
                .navigationTitle("Home")
            ForEach(purchaseManager.products) { product in
                
                if (!purchaseManager.purchasedProducts.contains(product.id)) {
                    Button {
                        Task {
                            do {
                                try await purchaseManager.purchase(product)
                            } catch {
                                print(error)
                            }
                        }
                        
                        print(product.id)
                        print(product)
                    } label: {
                        Text("\(product.displayPrice) - \(product.displayName)")
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                } else {
                    Text("\(product.displayName) alredy was buyd")
                }
                
            }
            
            Button {
                Task {
                    do {
                        try await AppStore.sync()
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Restore Purchases")
            }
            
            Button {
//                print(purchaseManager.purchasedProducts)
//                print(purchaseManager.purchasedProducts.contains("no_ads"))
//                for item in purchaseManager.purchasedProducts {
//                    print(item)
//                }
                
//                print(url.query!)
//                print(url.query!.components(separatedBy: "&") )
                let components = url.query!.components(separatedBy: "&")
                for itemPaymentsElement in purchaseManager.products {
                    print("itemPaymentsElement first print log")
                    
                    for itemKey in purchaseManager.purchasedProducts {
                        print("itemPayments first log")
                        
                        for item in components {
                            if (item.components(separatedBy: "=")[0] == "id") {
                                print(item.components(separatedBy: "=")[1] )
                                if("free_cooke" == itemPaymentsElement.id) {
//                                if(item.components(separatedBy: "=")[1] == itemPaymentsElement.id) {
                                    print("itemPayments: \(itemKey)")
                                    print("itemPaymentsElement: VVV")
                                    print(itemPaymentsElement)
                                    print(itemPaymentsElement.id)
                                } else {
                                    print("id from url != itemPaymentsElement.id: \(itemPaymentsElement.id)")
                                }
                            }
                            
                            if (item.components(separatedBy: "=")[0] == "price") {
                                print(item.components(separatedBy: "=")[1] )
                                if(item.components(separatedBy: "=")[1] == "100") {
                                    print("itemPayments \(itemKey)")
                                }
                            }
                            
                            if (item.components(separatedBy: "=")[0] == "item") {
                                print(item.components(separatedBy: "=")[1] )
                                if(item.components(separatedBy: "=")[1] == "consultM") {
                                    print("itemPayments \(itemKey)")
                                }
                            }
                        }
                    }
                }
                
            } label: {
                Text("Show log print")
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(Capsule())
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .background( .white)
        .padding(.top, 100)
        .navigationBarBackButtonHidden(true)
        .task {
            do {
                print("loadProducts")
                try await purchaseManager.loadProducts()
            } catch {
                print(error)
            }
        }
        
        //                VStack {
        //                    if true {
        //                        //            if entitlementManager.hasPro {
        //                        ScrollView(showsIndicators: false) {
        //                            VStack {
        //                                Text("Thank you for purchasing")
        //                                //                        purchasedProducts
        //                                Button {
        //                                    print(purchaseManager.purchasedProducts)
        //                                    print(purchaseManager.products)
        //                                    for item in purchaseManager.purchasedProducts {
        //                                        print(item)
        //                                    }
        //
        //                                } label: {
        //                                    Text("Show log print")
        //                                        .foregroundColor(.white)
        //                                        .padding()
        //                                        .background(.blue)
        //                                }
        //                            }
        //                            .padding(.top, 70)
        //                        }
        //                        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //                        .background(.black)
        //
        //                    } else {
        //                        List {
        //                            Text("ProfileScreen product")
        //                                .navigationTitle("Home")
        //                            ForEach(purchaseManager.products) { product in
        //                                Button {
        //                                    Task {
        //                                        do {
        //                                            try await purchaseManager.purchase(product)
        //                                        } catch {
        //                                            print(error)
        //                                        }
        //                                    }
        //                                } label: {
        //                                    Text("\(product.displayPrice) - \(product.displayName)")
        //                                        .foregroundColor(.white)
        //                                        .padding()
        //                                        .background(.blue)
        //                                        .clipShape(Capsule())
        //                                }
        //
        //                                Button {
        //                                    Task {
        //                                        do {
        //                                            try await AppStore.sync()
        //                                        } catch {
        //                                            print(error)
        //                                        }
        //                                    }
        //                                } label: {
        //                                    Text("Restore Purchases")
        //                                }
        //                            }
        //                        }.task {
        //                            do {
        //                                print("loadProducts")
        //                                try await purchaseManager.loadProducts()
        //                            } catch {
        //                                print(error)
        //                            }
        //                        }
        //                    }
        //
        //                }
        //                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        //                .background( .white)
        //                .padding(.top, 30)
        //                .navigationBarBackButtonHidden(true)
        //                .task {
        //                    Task {
        //                        do {
        //                            try await purchaseManager.loadProducts()
        //                        } catch {
        //                            print(error)
        //                        }
        //                    }
        //                }
        
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
