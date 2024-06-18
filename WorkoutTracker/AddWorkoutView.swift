//
//  AddWorkoutView.swift
//  WorkoutTracker
//
//  Created by Timur on 6/11/24.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var workouts: [WorkoutEntity]
    @Binding var selectedDate: Date
    @State private var exerciseName = ""
    @State private var sets = ""
    @State private var weight = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise")) {
                    TextField("Name", text: $exerciseName)
                    TextField("Sets", text: $sets)
                        .keyboardType(.numberPad)
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                }
                
                Button(action: addWorkout) {
                    Text("Add Workout")
                }
            }
            .navigationBarTitle("Add Workout")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func addWorkout() {
        guard let sets = Int(sets),
              let weight = Double(weight) else {
            // Show some error message to the user if needed
            return
        }

        let newExercise = Exercise(name: exerciseName, sets: sets, weight: weight)
        let newWorkout = WorkoutManager.shared.createWorkout(date: selectedDate, exercises: [newExercise])
        WorkoutManager.shared.saveWorkout(newWorkout)
        workouts = WorkoutManager.shared.loadWorkouts()

        presentationMode.wrappedValue.dismiss()
    }
}




