//
//  SwiftUIView.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 8/7/23.
//

import SwiftUI

struct RibbonFormView: View {
    @ObservedObject var vm: RibbonFormViewModel
    @EnvironmentObject var store: RibbonsDataStore
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                RibbonItemView(ribbon: Ribbon(title: vm.title, icon:vm.icon, line1: vm.line1, line2:vm.line2, scheme: vm.scheme, endDate: vm.endDate)
                    ).clipShape(RoundedRectangle(cornerRadius: 20))
                Form {
                    TextField("Title", text: $vm.title)
                    TextField("Line 1", text: $vm.line1)
                    TextField("Line 2", text: $vm.line2)
                    Picker(selection: $vm.scheme) {
                        ForEach(Scheme.allCases, id: \.self) { scheme in
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.bgColor(scheme: scheme))
                                .frame(width:70)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 0.5)
                                        .foregroundColor(Color.labelColor(scheme: scheme))
                                }
                        }
                    } label: {
                        Text("Color Scheme")
                        
                    }
                    
                    Picker(selection: $vm.icon) {
                        ForEach(Icon.iconSymbols, id: \.self) {symbol  in
                            Group {
                                symbol.isEmpty ? Image("ribbonIcon")
                                :
                                Image(systemName: symbol)
                                
                            }.foregroundColor(Color.labelColor(scheme: vm.scheme))
                        }
                    } label: {
                        Text("Icon")
                    }
                    Button {
                        if vm.endDate == Date.distantPast{
                            vm.endDate = Date()
                        } else {
                            vm.endDate = Date.distantPast
                        }
                    } label: {
                        Text(vm.endDate == Date.distantPast ? "Set End Date" : "Clear End Date")
                    }
                    if vm.endDate != Date.distantPast {
                        DatePicker(selection: $vm.endDate, displayedComponents: .date) {
                            Text("Date")
                        }
                        .datePickerStyle(.compact)
                    }
                

                }
            }.navigationTitle(vm.updating ? "Update" : "New Ribbon")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem (placement: .navigationBarLeading) {
                        HStack {
                            Button {
                                dismiss()
                                
                            } label: {
                                Text("Cancel")
                            }
                            if vm.updating {
                                Button {
                                    store.deleteRibbon(ribbon: vm.newOrUpdateRibbon)
                                    dismiss()
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                
                            }
                        }
                    }
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Button {
                            if vm.updating {
                                store.updateRibbon(ribbon: vm.newOrUpdateRibbon)
                            } else {
                                store.createRibbon(ribbon: vm.newOrUpdateRibbon)
                            }
                            dismiss()
                        } label: {
                            Text(vm.updating ? "Update" : "Create")
                        }
                    }
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RibbonFormView(vm: RibbonFormViewModel(selectedRibbon: Ribbon.mockRibbons[3]))
    }
}
