//
//  ActivitiesView.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

struct ActiviesInSetVC: View {
    
    @Binding var singleActivitySet: ActivitySets
    @State var setsa1 = [ActivitySets(name: "School", activities: [Activity(name1: "Brushing", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5), Activity(name1: "Bathing", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5)]), ActivitySets(name: "Work", activities: [Activity(name1: "Dressing up", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5)])]
    @State var isSheetEnabled5 = false
    @State var isSheetEnabled6 = false
    @State var selectedActivity: Activity? = nil
    @Binding var setsa: [ActivitySets]
    
    var body: some View {
        List {
            ForEach(singleActivitySet.activities) { activity in
                VStack(alignment:.leading){
                    Text(activity.name1 )
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                        .fontWeight(.semibold)
                        .padding(.vertical)
                    Spacer()
                    
                    HStack {
                        Text(activity.Priority)
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                            .fontWeight(.regular)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                . frame(width: 100, height:50)
                                .foregroundColor(Color(red: 0.6431372549019608, green: 0.6078431372549019, blue: 0.9568627450980393))
                            
                            Button {
                                selectedActivity = activity
                            } label: {
                                Text("Edit")
                                    .foregroundColor(.white)
                            }.frame(width: 100, height:50)
                        }
                    }
                }.listRowBackground(Color(hue: 0.742, saturation: 0.044, brightness: 0.979))
                
            }
            
            .onDelete { offsets in
                singleActivitySet.activities.remove(atOffsets: offsets)
            }.onMove { source, destination in
                singleActivitySet.activities.move(fromOffsets: source, toOffset: destination)
            }
            
        }   .buttonStyle(.plain)
            .navigationBarTitle(Text("Activities"))
            .navigationBarItems(trailing: Button(action: {
                isSheetEnabled6 = true
            }) {
                Image(systemName: "plus")
            })
            .navigationBarItems(trailing: EditButton())
            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
            .sheet(item: $selectedActivity){ selectedEvent1 in
                EditActivityVC(event: selectedEvent1){editAction in
                    switch editAction {
                    case .cancel:
                        break
                    case .delete:
                        
                        for (index, activity) in singleActivitySet.activities.enumerated() {
                            if activity.id == selectedEvent1.id {
                                singleActivitySet.activities.remove(at: index)
                                for (index, activity) in setsa.enumerated() {
                                    if activity.id == singleActivitySet.id {
                                        setsa[index] = singleActivitySet
                                    }
                                }
                            }
                        }
                    case .save(let event):
                        print(event)
                        for (index, activity) in singleActivitySet.activities.enumerated(){
                            if activity.id == event.id {
                                singleActivitySet.activities[index] = event
                                print(singleActivitySet.activities)
                            }
                        }
                        
                        for (index, activity) in setsa.enumerated() {
                            if activity.id == singleActivitySet.id {
                                setsa[index] = singleActivitySet
                            }
                        }
                        self.selectedActivity = nil
                        
                    }
                }
            }
            .sheet(isPresented: $isSheetEnabled6){
                NewActivityVC { newActivity in
                    singleActivitySet.activities.append(newActivity)
                    for (index, activity) in setsa.enumerated() {
                        if activity.id == singleActivitySet.id {
                            setsa[index] = singleActivitySet
                        }
                    }
                }
            }
    }
    
    struct ActiviesInSet_Previews: PreviewProvider {
        static var previews: some View {
            ActiviesInSetVC(singleActivitySet: .constant(ActivitySets(name: "Test", activities: [Activity(name1: "Test", timeSpending: 5, Percentage: "10", Priority: "3", minTime: 2, maxTime: 5)])), setsa: .constant([ActivitySets(name: "School", activities: [Activity(name1: "Brushing", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5), Activity(name1: "Bathing", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5)]), ActivitySets(name: "Work", activities: [Activity(name1: "Dressing up", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5)])])).preferredColorScheme(.light)
        }
    }
}
