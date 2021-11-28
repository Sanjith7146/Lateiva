//
//  ActivitySets.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import Foundation

struct ActivitySets : Identifiable, Codable{
    var id = UUID()
    var name : String
    var activities : [Activity]
}
