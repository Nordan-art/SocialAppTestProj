//
//  AppStoreManager.swift
//  SocialApp
//
//  Created by Danik on 12.01.23.
//

import Foundation
import StoreKit

@MainActor
class PurchaseManager: ObservableObject {
    
    private let productIds = ["no_ads", "free_cooke", "one_week_deliv"]
    
    @Published
    private(set) var products: [Product] = []
    
    @Published
    private(set) var purchasedProductIDs = Set<String>()
    
    @Published
    private(set) var purchasedProducts: [String] = []
    
    private let entitlementManager: EntitlementManager
    private var productsLoaded = false
    private var updates: Task<Void, Never>? = nil
    
    init(entitlementManager: EntitlementManager) {
        print(entitlementManager)
        self.entitlementManager = entitlementManager
        self.updates = observeTransactionUpdates()
    }
    
    deinit {
        self.updates?.cancel()
    }
    
    var hasUnlockedPro: Bool {
//        print("products: \(products)")
//        print("products: \(products.count)")
//        print("purchasedProductIDs: \(purchasedProductIDs)")
//        print(!self.purchasedProductIDs.isEmpty)
        return !self.purchasedProductIDs.isEmpty
    }
    
    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
//        print("array what i get when order all purchase item\(try await Product.products(for: productIds))")
//        print("count the length of purchese item \(try await Product.products(for: productIds).count)")
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
//        print("products ================= \(products)")
    }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        switch result {
        case let .success(.verified(transaction)):
            // Successful purhcase
            await transaction.finish()
            await self.updatePurchasedProducts()
        case let .success(.unverified(_, error)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
                print("success but device are unverified")
            break
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            print("Pending for payment sction")
            break
        case .userCancelled:
            print(result)
            print("user cancel payment action")
            // ^^^
            break
        @unknown default:
            break
        }
    }
    
    func updatePurchasedProducts() async {
        print("before cycle, on of update func")
        print(Transaction.currentEntitlements)
        for await result in Transaction.currentEntitlements {
            print("before verified")
            print("before verified result: \(result)")
            guard case .verified(let transaction) = result else {
                continue
            }
            print("result: \(result)")
            print("transaction: \(transaction)")
            print("transaction.productID: \(transaction.productID)")
            print("transaction.productType: \(transaction.productType)")
            if transaction.revocationDate == nil {
//                print("insert \(transaction.productID)")
                self.purchasedProductIDs.insert(transaction.productID)
                self.purchasedProducts.append(transaction.productID)
                print(purchasedProducts)
            } else {
//                print("remove \(transaction.productID)")
                self.purchasedProductIDs.remove(transaction.productID)
                for item in purchasedProducts {
                    if item == transaction.productID {
                        purchasedProducts.remove(at: purchasedProducts.firstIndex(of: transaction.productID)!)
                        print(purchasedProducts)
                    }
                }
            }
        }
        self.entitlementManager.hasPro = !self.purchasedProductIDs.isEmpty
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            //            for await verificationResult in Transaction.updates {
            for await _ in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
            }
        }
    }
    
}
