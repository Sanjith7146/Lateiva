//
//  EventsData.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import Foundation
import SwiftUI

class EventsData: ObservableObject {
    @Published var events: [Event] = []
    
    let sampleEvents = [Event(name: "This is a sample", Location: "Please create your event", date: Date.now)]
    
    func getArchiveURL() -> URL {
        let plistName = "events.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedEvents = try? propertyListEncoder.encode(events)
        try? encodedEvents?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalEvents: [Event]!
        
        if let retrievedEventsData = try? Data(contentsOf: archiveURL),
           let decodedEvents = try? propertyListDecoder.decode([Event].self, from: retrievedEventsData) {
            finalEvents = decodedEvents
        } else {
            finalEvents = sampleEvents
        }
        
        events = finalEvents
    }
}
