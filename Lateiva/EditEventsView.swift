//
//  editEvents.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

enum EditAction {
    case cancel
    case delete
    case save (Event)
}

struct editEventsVC: View {
    
    init(event: Event, dismiss: @escaping (EditAction) -> Void) {
        self.dismiss = dismiss
        self._event = State(initialValue: event)
    }
    
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    @State var event: Event
    var dismiss : (EditAction) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Information")) {
                    TextField("Name", text: $event.name).listRowSeparator(.visible)
                    
                    TextField("Location", text: $event.Location).listRowSeparator(.visible)
                    
                    DatePicker(
                        "Date",
                        selection: $event.date,
                        in: Date.now...Date.now.addingTimeInterval(31536000),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 0.796, green: 0.796, blue: 0.805))
                        .padding(.bottom)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button {
                            dismiss(.save(event))
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
                            dismiss(.delete)
                        } label: {
                            Text("Delete Eevnt")
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 60)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Edit event")
            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
            .navigationBarItems(trailing: Button(action: {
                dismiss(.cancel)
            }, label: {
                Text("Cancel")
                    .foregroundColor(.red)
            }))
        }
    }
}

struct editEvents_Previews: PreviewProvider {
    static var previews: some View {
        editEventsVC(event: Event(name: "School", Location: "SST", date: Date.now)) { _ in
            
        }.preferredColorScheme(.light)
    }
}
