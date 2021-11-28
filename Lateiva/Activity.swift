//
//  Activity.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import Foundation

struct Activity : Identifiable, Codable {
    var id = UUID()
    var name1 : String
    var timeSpending : Int
    var Percentage: String
    var Priority : String
    var minTime : Int
    var maxTime: Int
}
