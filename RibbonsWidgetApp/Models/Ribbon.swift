//
//  Ribbon.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import SwiftUI

struct Ribbon: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String = "Title"
    var icon: String = ""
    var line1 : String = "Line 1"
    var line2 : String = "Line 2"
    var scheme: Scheme = .default
    var endDate: Date = Date.distantPast
    var iconImage: Image {
        if icon == "" {
            return Image("ribbonIcon")
        } else {
            return Image(systemName: icon)
        }
    }
}

extension Ribbon {
    static var mockRibbons: [Ribbon] {
        [
            Ribbon(title: "Ramada Inn", icon: "key.fill", line1: "210", line2: "912345", scheme: .sunny),
            Ribbon(title: "Car Rental", icon: "car.fill", line1: "AAP R5T", line2: "Kia Sorento", scheme: .default),
            Ribbon(title: "Emily", icon: "crown.fill", line1: "July 6", line2: "Purchase present", scheme: .ruby, endDate: Date().addDays(numDays: 200)),
            Ribbon(title: "YVR-OGG", icon: "airplane", line1: "United 1523", line2: "5:25", scheme: .brown, endDate: Date()),
            Ribbon( title: "Theatre", icon: "ticket.fill", line1: "Come From Away", line2: "Orpheum", scheme: .teal),
            Ribbon(title: "Credit Card", icon: "banknote.fill", line1: "Pay Bill", line2: "", scheme: .midnight, endDate: Date().addDays(numDays: -1)),
            Ribbon(title: "Book Dentist Apointment", line1: "Doctor Ham", line2: "604-512-2512", scheme: .yellow, endDate: Date().addDays(numDays: 1)),
            Ribbon(title: "Pool Code", icon: "key.fill", line1: "24671", line2: "8am - 9pm", scheme: .gray)
        ]
    }
}
