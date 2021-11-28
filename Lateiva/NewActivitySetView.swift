//
//  NewActivitySetView.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

struct newActivitySetVC: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var ActiviteSet: [ActivitySets]
    @State var ActivtysetNew = ActivitySets( name: "", activities: [Activity(name1: "", timeSpending: 0, Percentage: "", Priority: "", minTime: 0, maxTime: 0)])
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Information")) {
                    TextField("Name", text: $ActivtysetNew.name).listRowSeparator(.visible)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            ActiviteSet.append(ActivtysetNew)
                            
                        } label: {
                            Text("Save")
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 60)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 60)
                        Spacer()
                    }
                }
                
            }
            .navigationTitle("New Activity Set")
            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
        }
    }
}

struct newActivitySet_Previews: PreviewProvider {
    static var previews: some View {
        newActivitySetVC(ActiviteSet: .constant([])).preferredColorScheme(.light)
    }
}
