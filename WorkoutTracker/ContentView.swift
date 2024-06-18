//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Timur on 6/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var workouts: [WorkoutEntity] = WorkoutManager.shared.loadWorkouts()
    @State private var showingAddWorkoutView = false
    @State private var isCalendarExpanded = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) { 
                CalendarView(selectedDate: $selectedDate, isExpanded: $isCalendarExpanded)
                    .frame(height: isCalendarExpanded ? 300 : 150)
                Button(action: {
                    withAnimation {
                        isCalendarExpanded.toggle()
                    }
                }) {
                    Text(isCalendarExpanded ? "Show Less" : "Show More")
                        .foregroundColor(.blue)
                }
                .padding(.top, 5)
                
                List {
                    ForEach(workoutsForSelectedDate) { workout in
                        VStack(alignment: .leading) {
                            ForEach(workout.exercises ?? []) { exercise in
                                Text("\(exercise.name): \(exercise.sets) sets, \(exercise.weight, specifier: "%.1f") kg")
                            }
                        }
                    }
                    .onDelete(perform: deleteWorkout)
                }
            }
            .navigationTitle("Workouts")
            .navigationBarItems(trailing: Button(action: {
                showingAddWorkoutView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddWorkoutView) {
                AddWorkoutView(workouts: $workouts, selectedDate: $selectedDate)
            }
        }
    }
    
    var workoutsForSelectedDate: [WorkoutEntity] {
        return workouts.filter {
            Calendar.current.isDate($0.date!, inSameDayAs: selectedDate)
        }
    }
    
    private func deleteWorkout(at offsets: IndexSet) {
        let workoutsForSelectedDate = self.workoutsForSelectedDate
        offsets.forEach { index in
            let workout = workoutsForSelectedDate[index]
            WorkoutManager.shared.deleteWorkout(workout)
            self.workouts = WorkoutManager.shared.loadWorkouts()
        }
    }
}


#Preview {
    ContentView()
}
