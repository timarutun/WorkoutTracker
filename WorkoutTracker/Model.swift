//
//  Model.swift
//  WorkoutTracker
//
//  Created by Timur on 6/11/24.
//

import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var sets: Int
    var weight: Double
}

struct Workout: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var exercises: [Exercise]
}
