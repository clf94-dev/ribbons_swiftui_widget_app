//
//  LargeWidget.swift
//  RibbonWidgetExtension
//
//  Created by Carmen Lucas on 9/7/23.
//

import WidgetKit
import SwiftUI

struct LargeProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> LargeEntry {
        LargeEntry(date: Date(), ribbon: Ribbon(), ribbon2: Ribbon(), ribbon3: Ribbon(), ribbon4: Ribbon(), configuration: LargeChoiceConfigIntent())
    }

    func getSnapshot(for configuration: LargeChoiceConfigIntent,in context: Context, completion: @escaping (LargeEntry) -> ()) {
        let ribbon = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        let ribbon2 = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        let ribbon3 = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        let ribbon4 = RibbonsDataStore().ribbons.randomElement() ?? Ribbon()
        
        let entry = LargeEntry(date: Date(), ribbon: ribbon, ribbon2: ribbon2,ribbon3: ribbon3, ribbon4: ribbon4, configuration: configuration)
        completion(entry)
    }

    func selectedRibbon (for configuration: LargeChoiceConfigIntent, selection: Int) -> Ribbon {
        var selectedId = ""
        switch selection{
        case 1:
            guard let id = configuration.selectedRibbon1?.identifier else {
                return Ribbon.instructionRibbon
            }
            selectedId = id
        case 2:
            guard let id = configuration.selectedRibbon2?.identifier else {
                return Ribbon.instructionRibbon
            }
            selectedId = id
        case 3:
            guard let id = configuration.selectedRibbon3?.identifier else {
                return Ribbon.instructionRibbon
            }
            selectedId = id
            
        default:
            guard let id = configuration.selectedRibbon4?.identifier else {
                return Ribbon.instructionRibbon
            }
            selectedId = id
        }
        return RibbonsDataStore().ribbons.first{$0.id == selectedId} ?? Ribbon.instructionRibbon
    }
    func getTimeline(for configuration: LargeChoiceConfigIntent,in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
 
        let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let ribbon = selectedRibbon(for: configuration, selection: 1)
        let ribbon2 = selectedRibbon(for: configuration, selection: 2)
        let ribbon3 = selectedRibbon(for: configuration, selection: 3)
        let ribbon4 = selectedRibbon(for: configuration, selection: 4)

        let entry = LargeEntry(date: entryDate, ribbon: ribbon, ribbon2: ribbon2, ribbon3: ribbon3,  ribbon4: ribbon4, configuration: configuration)
       

        let timeline = Timeline(entries: [entry], policy: .after(entryDate))
        completion(timeline)
    }
}

struct LargeEntry: TimelineEntry {
    let date: Date
    let ribbon: Ribbon
    let ribbon2: Ribbon
    let ribbon3: Ribbon
    let ribbon4: Ribbon
    
    let configuration: LargeChoiceConfigIntent
}

struct LargeWidgetEntryView : View {
    var entry: LargeProvider.Entry

    var body: some View {
        VStack {
            HStack(spacing:12) {
                Link (destination: URL(string: "ribbon:///\(entry.ribbon.id)")!) {
                    RibbonItemView(ribbon: entry.ribbon)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Link (destination: URL(string: "ribbon:///\(entry.ribbon2.id)")!) {
                    RibbonItemView(ribbon: entry.ribbon2)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            } .scaleEffect(WidgetSize.scaleFactor(.large))
            HStack(spacing:12) {
                Link (destination: URL(string: "ribbon:///\(entry.ribbon3.id)")!) {
                    RibbonItemView(ribbon: entry.ribbon3)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Link (destination: URL(string: "ribbon:///\(entry.ribbon4.id)")!) {
                    RibbonItemView(ribbon: entry.ribbon4)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            } .scaleEffect(WidgetSize.scaleFactor(.large))
          
        }
    }
}

struct LargeWidget: Widget {
    let kind: String = "Large Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: LargeChoiceConfigIntent.self, provider: LargeProvider()) { entry in
            LargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Ribbons")
        .description("Add four ribbons to your home screen.")
        .supportedFamilies([.systemLarge])
    }
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidgetEntryView(entry: LargeEntry(date: Date(), ribbon: Ribbon.mockRibbons[3], ribbon2: Ribbon.mockRibbons[5], ribbon3: Ribbon.mockRibbons[6], ribbon4: Ribbon.mockRibbons[2], configuration: LargeChoiceConfigIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
