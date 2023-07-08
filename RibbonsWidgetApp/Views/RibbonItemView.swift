//
//  RibbonItemView.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import SwiftUI

struct RibbonItemView: View {
    var ribbon: Ribbon
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                ribbon.iconImage
                    .resizable()
                    .scaledToFit()
                    .frame(width:30, height:30)
                Text(ribbon.title)
                    .font(.system(size: 17))
                    .bold()
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            Text(ribbon.line1)
                .font(.system(size: 28))
                .minimumScaleFactor(0.5)
            Text(ribbon.line2)
                .font(.system(size: 17))
                .minimumScaleFactor(0.5)
            Spacer()
            if ribbon.endDate != Date.distantPast {
                Text(ribbon.endDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.system(size: 17))
            }
            
            
            
        }.foregroundColor(Color.labelColor(scheme: ribbon.scheme))
            .padding()
            .frame(width: 170, height: 170)
            .background(Color.bgColor(scheme: ribbon.scheme))
            .overlay {
                if ribbon.endDate == Date.distantPast {
                    warningView(text: "Overdue")
                } else if ribbon.endDate.startOfDay == Date().startOfDay {
                    warningView(text: "Due Today")
                }
                    
            }
    }
    func warningView(text: String) -> some View {
        Text("\(text)")
            .font(.system(size: 28))
            .bold()
            .rotationEffect(Angle(degrees: -45))
            .foregroundColor(Color.labelColor(scheme: ribbon.scheme))
            .shadow(radius: 3, x: 3, y: 3)
            .minimumScaleFactor(0.5)
    
    }
    
}

struct RibbonItemView_Previews: PreviewProvider {
    static var previews: some View {
        RibbonItemView(ribbon: Ribbon.mockRibbons[3])
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
