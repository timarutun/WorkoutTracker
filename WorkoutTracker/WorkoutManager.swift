//
//  WorkoutManager.swift
//  WorkoutTracker
//
//  Created by Timur on 6/11/24.
//

import Foundation

class WorkoutManager {
    static let shared = WorkoutManager()
    
    private let workoutsKey = "workouts"
    
    func saveWorkout(_ workout: Workout) {
        var workouts = loadWorkouts()
        workouts.append(workout)
        if let data = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(data, forKey: workoutsKey)
        }
    }
    
    func loadWorkouts() -> [Workout] {
        if let data = UserDefaults.standard.data(forKey: workoutsKey),
           let workouts = try? JSONDecoder().decode([Workout].self, from: data) {
            return workouts
        }
        return []
    }
}

