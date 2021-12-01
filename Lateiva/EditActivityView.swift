//
//  EditActivityView.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

enum EditAction1 {
    case cancel
    case delete
    case save (Activity)
    
}

struct EditActivityVC: View {
    @State var EditActivities: Activity
    @Environment(\.presentationMode) var presentationMode
    
    var dismiss : (EditAction1) -> Void
    
    init(event: Activity, dismiss: @escaping (EditAction1) -> Void) {
        self.dismiss = dismiss
        self._EditActivities = State(initialValue: event)
        
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $EditActivities.name1).listRowSeparator(.visible)
                }
                Section(header: Text("Time")) {
                    
                    Stepper("Min time: \(EditActivities.minTime)", value: $EditActivities.minTime, in: 0...EditActivities.maxTime)
                    
                    Stepper("Max time: \(EditActivities.maxTime)", value: $EditActivities.maxTime, in: EditActivities.minTime...100000000000)
                }
                
                Section(header: Text("Priority")) {
                    
                    Picker("Priority", selection: $EditActivities.Priority) {
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
                            dismiss(.save(EditActivities))
                        } label: {
                            Text("Save")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            dismiss(.cancel)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Discard Changes")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Edit Activity")
            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
        }
    }
}

struct EditActivityVC_Previews: PreviewProvider {
    static var previews: some View {
        EditActivityVC(event:Activity(name1: "Brushing", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5)) { _ in
            
        }.preferredColorScheme(.light)
    }
}

