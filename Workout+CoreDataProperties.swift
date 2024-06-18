//
//  Workout+CoreDataProperties.swift
//  WorkoutTracker
//
//  Created by Timur on 6/18/24.
//
//

import Foundation
import CoreData

extension WorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutEntity> {
        return NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var exercisesData: Data?

    var exercises: [Exercise]? {
        get {
            if let data = exercisesData {
                return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Exercise]
            }
            return nil
        }
        set {
            exercisesData = try? NSKeyedArchiver.archivedData(withRootObject: newValue ?? [], requiringSecureCoding: false)
        }
    }
}

extension WorkoutEntity: Identifiable {
}


