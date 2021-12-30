//
//  NewActivityView.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

struct NewActivityVC: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @State var newActivity = Activity(name1: "", timeSpending: 0, Percentage: "", Priority: "", minTime: 1 , maxTime: 2)
    var newlyMadeActivity: (Activity) -> Void
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $newActivity .name1).listRowSeparator(.visible)
                    
                }
                Section(header: Text("Time")) {
                    
                    Stepper("Min time: \(newActivity.minTime)", value: $newActivity.minTime, in: 1...newActivity.maxTime)
                    
                    Stepper("Max Time: \(newActivity.maxTime)", value: $newActivity.maxTime, in: newActivity.minTime...1000000000)
                }
                
                Section(header: Text("Priority")) {
                    
                    Picker("Priority", selection: $newActivity.Priority) {
                        Text("Very High Priority").tag("Very High Priority")
                        Text("High Priority").tag("High Priority")
                        Text("Medium Priority").tag("Medium Priority")
                        Text("Low Priority").tag("Low Priority")
                        Text("Very Low Priority").tag("Very Low Priority")
                        
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button {
                            self.presentationMode.wrappedValue.dismiss();  newlyMadeActivity(newActivity)
                            print(newActivity.Priority)
                            UITableView.appearance().backgroundColor = .clear
                        } label: {
                            Text("Save")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            UITableView.appearance().backgroundColor = .clear
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("New Activity")
            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
        }.onAppear{
            UITableView.appearance().backgroundColor = UIColor(Color(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922))
        }
    }
}

struct NewActivity_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityVC(newlyMadeActivity: {_ in }).preferredColorScheme(.light)
    }
}
