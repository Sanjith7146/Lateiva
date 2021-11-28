//
//  LateivaApp.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

@main
struct LateivaApp: App {
    @ObservedObject var eventsData = EventsData()
    @ObservedObject var setsaData = ActivitySetssData()
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(red: 0.4627450980392157, green: 0.4235294117647059, blue: 0.8196078431372549))]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))]
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(events: $eventsData.events, setsa: $setsaData.setsa)
                .onAppear{
                    eventsData.load()
                    setsaData.load()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        eventsData.save()
                        setsaData.save()
                    }
                }
                
        }
    }
}
