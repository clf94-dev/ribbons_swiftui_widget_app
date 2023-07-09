//
//  ContentView.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import SwiftUI

struct AllRibbonsView: View {
    enum FormType: Identifiable {
        case new
        case update(Ribbon)
        var id: String {
            switch self {
            case .new:
                return "new"
            case .update:
                return "update"
            }
        }
    }
    @EnvironmentObject var store: RibbonsDataStore
    @State private var formType: FormType?
    
    var body: some View {
        let columns = [GridItem](repeating: GridItem(.fixed(170 * WidgetSize.scaleFactor)), count: 2)
        NavigationView {
            Group {
                if store.ribbons.isEmpty {
                    NoRibbonView()
                } else {
                    ScrollView {
                        LazyVGrid (columns: columns, spacing: 10) {
                            ForEach(store.ribbons) {ribbon in
                                Button {
                                    formType = .update(ribbon)
                                } label: {
                                    RibbonItemView(ribbon: ribbon)
                                    
                                }.clipShape(RoundedRectangle(cornerRadius: 20))
                                    .scaleEffect(WidgetSize.scaleFactor)
                            }
                        }
                        
                    }
                }
            }.navigationTitle("Ribbons")
                        .toolbar{
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    formType = .new
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                }
                                
                            }
                        }
                        .sheet(item: $formType) { formType in
                            if case FormType.update(let ribbon) = formType {
                                RibbonFormView(vm: RibbonFormViewModel(selectedRibbon: ribbon))
                            } else {
                                RibbonFormView(vm: RibbonFormViewModel())
                            }
                        
            }
            
        }
        .onChange(of: store.selectedRibbon) { ribbon in
            if ribbon != nil {
                formType = .update(ribbon!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            AllRibbonsView()
                .environmentObject(RibbonsDataStore())
            AllRibbonsView()
                .preferredColorScheme(.dark)
                .environmentObject(RibbonsDataStore())
        }
    }
}
