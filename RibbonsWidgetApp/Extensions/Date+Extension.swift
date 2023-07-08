//
//  Date+Extension.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func addDays (numDays: Int ) -> Date {
        Date(timeInterval: TimeInterval(numDays * 86400), since: self)
        
    }
}
