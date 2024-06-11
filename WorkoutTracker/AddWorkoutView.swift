//
//  AddWorkoutView.swift
//  WorkoutTracker
//
//  Created by Timur on 6/11/24.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var workouts: [Workout]
    @Binding var selectedDate: Date
    
    @State private var exercises: [Exercise] = []
    @State private var newExerciseName = ""
    @State private var newSets = ""
    @State private var newWeight = ""
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                
                Section(header: Text("Exercises")) {
                    ForEach(exercises) { exercise in
                        Text("\(exercise.name): \(exercise.sets) sets, \(exercise.weight, specifier: "%.1f") kg")
                    }
                    HStack {
                        TextField("Exercise Name", text: $newExerciseName)
                        TextField("Sets", text: $newSets)
                            .keyboardType(.numberPad)
                        TextField("Weight", text: $newWeight)
                            .keyboardType(.decimalPad)
                        Button(action: addExercise) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newExerciseName.isEmpty || newSets.isEmpty || newWeight.isEmpty)
                    }
                }
            }
            .navigationTitle("Add Workout")
            .navigationBarItems(trailing: Button("Save") {
                saveWorkout()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addExercise() {
        if let sets = Int(newSets), let weight = Double(newWeight) {
            let exercise = Exercise(name: newExerciseName, sets: sets, weight: weight)
            exercises.append(exercise)
            newExerciseName = ""
            newSets = ""
            newWeight = ""
        }
    }
    
    private func saveWorkout() {
        let workout = Workout(date: selectedDate, exercises: exercises)
        workouts.append(workout)
        WorkoutManager.shared.saveWorkout(workout)
    }
}

