//
//  RibbonsWidgetAppApp.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import SwiftUI

@main
struct RibbonsWidgetApp: App {
    @StateObject var store = RibbonsDataStore()
    var body: some Scene {
        WindowGroup {
            AllRibbonsView()
                .environmentObject(store)
        }
    }
}
