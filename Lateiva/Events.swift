//
//  Events.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import Foundation

struct Event : Identifiable, Equatable, Codable {
    var id = UUID()
    var name : String
    var Location : String
    var date : Date
    
}
