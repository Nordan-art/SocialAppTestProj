//
//  WebViewRenderScreen.swift
//  SocialApp
//
//  Created by Danik on 12.01.23.
//

import SwiftUI

struct stateContent {
    static var url: URL = URL(string: "https://crm.mcgroup.pl/mcgroup_crmAPI/alfa/task?id=23&item=consultM&price=100")!
//    static var url: URL = URL(string: "https://crm.mcgroup.pl/")!
//    http://crm.mcgroup.pl/mcgroup_crmAPI/alfa/task?id=23&item=consultM&price=100
}

struct WebViewRenderScreen: View {
        
    var body: some View {
        WebView(data: WebViewData(url: stateContent.url))
    }
}

struct WebViewRenderScreen_Previews: PreviewProvider {
    static var previews: some View {
        WebViewRenderScreen()
    }
}
