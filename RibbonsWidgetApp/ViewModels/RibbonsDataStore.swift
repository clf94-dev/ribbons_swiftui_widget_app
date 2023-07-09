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
        
        // ribbons = Ribbon.mockRibbons
        
        do {
            let data = try FileManager().readFile()
            ribbons = try JSONDecoder().decode([Ribbon].self, from: data)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveRibbons() {
        do {
            let data = try JSONEncoder().encode(ribbons)
            let jsonString = String(decoding:data, as: UTF8.self)
            try FileManager().saveFile(contents: jsonString)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
