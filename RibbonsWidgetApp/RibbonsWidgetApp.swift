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
                .onAppear{
                    // don't show errors of UIConstraint
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    
                    // find fileManager folder, where json is stored
                    print(FileManager.docDirURL.path)
                    print(FileManager.appGroupURL.path)
                }
                .environmentObject(store)
                .onOpenURL { url in
                    guard let urlScheme = url.scheme else { return }
                    if urlScheme  == "ribbon" {
                        store.selectedRibbonId = url.lastPathComponent
                    }
                }
        }
    }
}
