//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Timur on 6/18/24.
//

import Foundation

class Exercise: NSObject, NSCoding, Identifiable {
    var id: UUID
    var name: String
    var sets: Int
    var weight: Double

    init(name: String, sets: Int, weight: Double) {
        self.id = UUID()
        self.name = name
        self.sets = sets
        self.weight = weight
    }

    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! UUID
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let sets = aDecoder.decodeInteger(forKey: "sets")
        let weight = aDecoder.decodeDouble(forKey: "weight")
        self.init(name: name, sets: sets, weight: weight)
        self.id = id
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(sets, forKey: "sets")
        aCoder.encode(weight, forKey: "weight")
    }
}



