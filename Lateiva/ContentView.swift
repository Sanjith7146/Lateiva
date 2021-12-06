//
//  Events.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI


extension String{
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.date(from: self) ?? Date.now
    }
}

struct ContentView: View {
    
    func dateformmtter(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
    func secondDateformmtter(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    @State var showAlert = false
    @State var showAlert1 = false
    @State private var isShowingToast = false
    @State var selectedEvent: Event? = nil
    @State var isSheetEnabled2 = false
    @State var isSheetEnabled3 = false
    @Binding var events: [Event]
    @Binding var setsa: [ActivitySets]
    
    var filterevents: [Event] {
        return (events
                    .filter {Calendar.current.isDateInToday($0.date)}
                    .sorted {$0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970})
    }
    var filterevents1: [Event] {
        return( events
                    .filter {!Calendar.current.isDateInToday($0.date)}
                    .sorted {$0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970})
    }
    
    var body: some View {
        let groupByCategory = Dictionary(grouping: filterevents1) { (device) in
            return secondDateformmtter(date: device.date)
        }
        
        NavigationView {
            VStack(alignment:.leading){
                Text("   Tap on one of your events to continue")
                    .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                    .font(.system(size: 14))
                    .padding([.leading, .trailing])
                
                List {
                    Section(header: Text("Today")){
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
                                
                                
                            }   .padding()
                                .background(Color(hue: 0.742, saturation: 0.149, brightness: 0.99))
                                .cornerRadius(20)
                                .padding(.vertical, 1)
                                .listRowSeparator(.hidden)
                                .onAppear{
                                    UITableView.appearance().backgroundColor = .clear
                                }
                        }
                    }
                    .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                    
                    ForEach(groupByCategory.sorted{$0.key.toDate().timeIntervalSince1970 < $1.key.toDate().timeIntervalSince1970}, id: \.key){ i, key in
                        Section(header: Text(i)) {
                            ForEach(key) { event in
                                
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
                                }
                                .padding()
                                .background(Color(hue: 0.742, saturation: 0.149, brightness: 0.99))
                                .cornerRadius(20)
                                .padding(.vertical, 1)
                                .listRowSeparator(.hidden)
                                .onAppear{
                                    UITableView.appearance().backgroundColor = .clear
                                }
                            }
                        }
                        .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                        .listStyle(.plain)
                        .buttonStyle(.plain)
                    }
                }
                .buttonStyle(.plain)
                .navigationBarTitle(Text("Events"))
                .navigationBarItems(trailing: Button(action: {
                    isSheetEnabled2 = true
                }, label: {
                    Image(systemName: "plus")
                }))
                .navigationBarItems(leading: NavigationLink(destination: ActivitySetsForEditVC(setsa: $setsa)){
                    Text("Activities")
                })
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
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(events: .constant([Event(name: "This is a sample", Location: "Please create your event", date: Date.now)]), setsa: .constant([ActivitySets(name: "Sample", activities: [Activity(name1: "Create your Own Now", timeSpending: 2, Percentage: "100%", Priority: "Click on the + icon", minTime: 1, maxTime: 5)])])).environment(\.colorScheme, .light)
    }
}
