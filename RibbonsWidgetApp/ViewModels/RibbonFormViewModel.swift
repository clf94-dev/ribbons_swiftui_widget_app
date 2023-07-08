//
//  RibbonFormModel.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import Foundation

class RibbonFormViewModel: ObservableObject {
    @Published var title: String = "Title"
    @Published var icon: String = ""
    @Published var line1 : String = "Line 1"
    @Published var line2 : String = "Line 2"
    @Published var scheme: Scheme = .default
    @Published var endDate: Date = Date.distantPast
    
    var id:String?
    
    var updating: Bool {
        id != nil
    }
    
    init(selectedRibbon:Ribbon){
        title = selectedRibbon.title
        icon = selectedRibbon.icon
        line1 = selectedRibbon.line1
        line2 = selectedRibbon.line2
        scheme = selectedRibbon.scheme
        endDate = selectedRibbon.endDate
        id = selectedRibbon.id
    }
    init() {}
    
}
