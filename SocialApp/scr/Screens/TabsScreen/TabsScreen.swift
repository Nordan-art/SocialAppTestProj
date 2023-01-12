//
//  TabsScreen.swift
//  SocialApp
//
//  Created by Danik on 9.01.23.
//

import SwiftUI

struct TabsScreen: View {
    
    @StateObject
    private var entitlementManager: EntitlementManager
    
    @StateObject
    private var purchaseManager: PurchaseManager
    
    init() {
        let entitlementManager = EntitlementManager()
        let purchaseManager = PurchaseManager(entitlementManager: entitlementManager)
        
        self._entitlementManager = StateObject(wrappedValue: entitlementManager)
        self._purchaseManager = StateObject(wrappedValue: purchaseManager)
    }
    
    var body: some View {
        ZStack {
            TabView {
                
                Group {
                    
                    HomeScreenMain()
                        .tabItem {
                            Label("", systemImage: "house.fill")
                        }
                    
                    SearchSreen()
                        .tabItem {
                            Label("", systemImage: "square.and.pencil")
                        }
                    
                    ProfileScreen()
                        .environmentObject(entitlementManager)
                        .environmentObject(purchaseManager)
                        .task {
                            await purchaseManager.updatePurchasedProducts()
                        }
                        .tabItem {
                            Label("", systemImage: "person.circle.fill")
                        }
                        .badge(3)
                }
                .toolbarColorScheme(.dark, for: .tabBar)
                
            }
            //            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            //            .toolbarBackground(.red, for: .tabBar)
        }
        .safeAreaInset(edge: .top, alignment: .center, spacing: 45) {
            Color.clear
                .frame(height: 20)
                .background(Material.bar)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabsScreen()
    }
}
