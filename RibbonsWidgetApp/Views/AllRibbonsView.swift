//
//  ContentView.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import SwiftUI

struct AllRibbonsView: View {
    @EnvironmentObject var store: RibbonsDataStore
    var body: some View {
        let columns = [GridItem](repeating: GridItem(.fixed(170)), count: 2)
        NavigationView {
            ScrollView {
                LazyVGrid (columns: columns, spacing: 10) {
                    ForEach(store.ribbons) {ribbon in
                        RibbonItemView(ribbon: ribbon)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                }
            }.navigationTitle("Ribbons")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllRibbonsView()
            .environmentObject(RibbonsDataStore())
    }
}
