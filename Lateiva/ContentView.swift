//
//  Events.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedEvent: Event? = nil
    @State var isSheetEnabled2 = false
    @State var isSheetEnabled3 = false
    @Binding var events: [Event]
    @Binding var setsa: [ActivitySets]
    
    var filterevents: [Event] {
        return events.filter {Calendar.current.isDateInToday($0.date)}
    }
    
    var body: some View {
        
        NavigationView {
            VStack(alignment:.leading){
                Text(" Tap on one of your events to continue")
                    .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                    .font(.system(size: 14))
                    .padding([.leading, .trailing])
                
                List {
                    ForEach(filterevents) { event in
                        NavigationLink(destination: startTimeVC(setsa: $setsa)) {
                            
                            VStack(alignment:.leading){
                                
                                Spacer()
                                
                                Text(event.name)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(hue: 0.78, saturation: 1.0, brightness: 0.722))
                                    .fontWeight(.heavy)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                                
                                Text(event.Location)
                                    .font(.system(size: 18))
                                    .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                                
                                Spacer()
                                
                                HStack{
                                    Text(dateformmtter(date: event.date))
                                        .font(.system(size: 18))
                                        .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                                    
                                    Spacer()
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            . frame(width: 100, height:50)
                                            .foregroundColor(Color(red: 0.6431372549019608, green: 0.6078431372549019, blue: 0.9568627450980393))
                                        
                                        Button {
                                            selectedEvent = event
                                        } label: {
                                            Text("Edit")
                                                .foregroundColor(.white)
                                        }.frame(width: 100, height:50)
                                    }
                                }
                            }
                            .background(Color(hue: 0.742, saturation: 0.149, brightness: 0.99))
                            .cornerRadius(20)
                            .padding(.vertical, 1)
                            .listRowSeparator(.hidden)
                            
                            
                        }.padding()
                            .background(Color(hue: 0.742, saturation: 0.149, brightness: 0.99))
                            .cornerRadius(20)
                            .padding(.vertical, 1)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete { offsets in
                        events.remove(atOffsets: offsets)
                    }.onMove { source, destination in
                        events.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .listStyle(.plain)
                .buttonStyle(.plain)
            }
            .navigationBarTitle(Text("Events"))
            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
            .navigationBarItems(trailing: Button(action: {
                isSheetEnabled2 = true
            }, label: {
                Image(systemName: "plus")
            }))
            .navigationBarItems(leading: NavigationLink(destination: ActivitySetsForEditVC(setsa: $setsa)){
                Text("Activities")
            })
            .navigationBarItems(trailing: EditButton())
            
        }
        .sheet(item: $selectedEvent){ selectedEvent in
            editEventsVC(event: selectedEvent){editAction in
                switch editAction {
                case .cancel:
                    break
                case .delete:
                    events.remove(at: events.firstIndex(of: selectedEvent)!)
                case .save(let event):
                    events[events.firstIndex(of: selectedEvent)!] = event
                }
                self.selectedEvent = nil
            }
        }
        .sheet(isPresented: $isSheetEnabled2){
            newEventVC(evente: $events)
        }
    }
    
    func dateformmtter(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(events: .constant([Event(name: "This is a sample", Location: "Please create your event", date: Date.now)]), setsa: .constant([ActivitySets(name: "Sample", activities: [Activity(name1: "Create your Own Now", timeSpending: 2, Percentage: "100%", Priority: "Click on the + icon", minTime: 1, maxTime: 5)])])).environment(\.colorScheme, .light)
    }
}

