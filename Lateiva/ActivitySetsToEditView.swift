//
//  ActivitySetsToEditView.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI


struct ActivitySetsForEditVC: View {
    
    @State var isSheetEnabled4 = false
    @Binding var setsa: [ActivitySets]
    
    var body: some View {
        VStack(alignment:.leading){
            List{
                ForEach($setsa) { $singleSetsa in
                    NavigationLink(destination: ActiviesInSetVC(singleActivitySet: $singleSetsa, setsa: $setsa)) {
                        VStack(alignment:.leading){
                            Text(singleSetsa.name)
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                                .fontWeight(.semibold)
                                .padding(.vertical)
                        }
                    }
                    .listRowBackground(Color(hue: 0.742, saturation: 0.049, brightness: 0.984))
                    .sheet(isPresented: $isSheetEnabled4){
                        newActivitySetVC(ActiviteSet: $setsa)
                    }
                }.onDelete { offsets in
                    setsa.remove(atOffsets: offsets)
                    
                }.onMove { source, destination in
                    setsa.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle("Activity Sets")
            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
            .navigationBarItems(trailing: Button(action: {
                isSheetEnabled4 = true
            }, label: {
                Image(systemName: "plus")
            }))
            .navigationBarItems(trailing: EditButton())
            
        }
    }
}

struct ActivitySetsForEditVC_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySetsForEditVC(setsa: .constant([ActivitySets(name: "Sample", activities: [Activity(name1: "Create your own now", timeSpending: 2, Percentage: "100%", Priority: "Click on the + icon", minTime: 1, maxTime: 5)])])).preferredColorScheme(.light)
    }
}
