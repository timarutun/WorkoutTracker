//
//  WorkoutManager.swift
//  WorkoutTracker
//
//  Created by Timur on 6/11/24.
//

import Foundation
import CoreData
import UIKit

class WorkoutManager {
    static let shared = WorkoutManager()
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "WorkoutTrackerModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func loadWorkouts() -> [WorkoutEntity] {
        let request: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch workouts: \(error)")
            return []
        }
    }
    
    func saveWorkout(_ workout: WorkoutEntity) {
        do {
            try context.save()
        } catch {
            print("Failed to save workout: \(error)")
        }
    }
    
    func deleteWorkout(_ workout: WorkoutEntity) {
        context.delete(workout)
        do {
            try context.save()
        } catch {
            print("Failed to delete workout: \(error)")
        }
    }
    
    func createWorkout(date: Date, exercises: [Exercise]) -> WorkoutEntity {
        let workout = WorkoutEntity(context: context)
        workout.id = UUID()
        workout.date = date
        workout.exercises = exercises
        return workout
    }
}





