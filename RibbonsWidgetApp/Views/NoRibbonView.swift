//
//  NoRibbonView.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 9/7/23.
//

import SwiftUI

struct NoRibbonView: View {
    var body: some View {
        VStack{
            Image("noRibbons")
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
                .offset(y: 80)
            Text("Tap the plus button to create your first ribbon.")
                .font(.title2)
                .padding()
            Spacer()
        }.ignoresSafeArea()
    }
}

struct NoRibbonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoRibbonView()
                .navigationTitle("Ribbons")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }

                }
        }
    }
}
