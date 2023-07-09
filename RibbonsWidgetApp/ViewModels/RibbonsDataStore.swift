//
//  RibbonsDataStore.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import Foundation

class RibbonsDataStore: ObservableObject{
    @Published var ribbons: [Ribbon] = []
    @Published var selectedRibbonId: String?
    
    var selectedRibbon: Ribbon? {
        ribbons.first(where: {$0.id == selectedRibbonId})
    }
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
    func createRibbon(ribbon: Ribbon) {
        ribbons.append(ribbon)
            saveRibbons()
    }
    func updateRibbon(ribbon: Ribbon) {
        guard let index = selectedRibbonIndex(ribbon: ribbon) else { return }
        ribbons[index] = ribbon
        saveRibbons()
    }
    
    func deleteRibbon (ribbon: Ribbon) {
        guard let index = selectedRibbonIndex(ribbon: ribbon) else { return }
        ribbons.remove(at: index)
        saveRibbons()
    }
    private func selectedRibbonIndex(ribbon: Ribbon) -> Int? {
        guard let index = ribbons.firstIndex(where: {$0.id == ribbon.id})
        else { return nil }
        return index
    }
}
