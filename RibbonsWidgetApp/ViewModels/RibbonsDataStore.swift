//
//  RibbonsDataStore.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import Foundation

class RibbonsDataStore: ObservableObject{
    @Published var ribbons: [Ribbon] = []
    
    init() {
        loadRibbons()
    }
    
    private func loadRibbons() {
        ribbons = Ribbon.mockRibbons
    }
    
}
