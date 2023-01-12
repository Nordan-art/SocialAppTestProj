//
//  EntitlementManager.swift
//  SocialApp
//
//  Created by Danik on 12.01.23.
//

import Foundation
import SwiftUI

class EntitlementManager: ObservableObject {
    static let userDefaults = UserDefaults(suiteName: "group.your.app")!

    @AppStorage("hasPro", store: userDefaults)
    var hasPro: Bool = false
}
