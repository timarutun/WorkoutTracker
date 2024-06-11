//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Timur on 6/9/24.
//

import SwiftUI
import FSCalendar

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var workouts: [Workout] = WorkoutManager.shared.loadWorkouts()
    @State private var showingAddWorkoutView = false
    
    var body: some View {
        NavigationView {
            VStack {
                FSCalendarWrapper(selectedDate: $selectedDate)
                    .frame(height: 300)
                List {
                    ForEach(workoutsForSelectedDate) { workout in
                        VStack(alignment: .leading) {
                            ForEach(workout.exercises) { exercise in
                                Text("\(exercise.name): \(exercise.sets) sets, \(exercise.weight, specifier: "%.1f") kg")
                            }
                        }
                    }
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
    
    var workoutsForSelectedDate: [Workout] {
        return workouts.filter {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
    }
}

struct FSCalendarWrapper: UIViewRepresentable {
    @Binding var selectedDate: Date
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: FSCalendarWrapper
        
        init(_ parent: FSCalendarWrapper) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
        
        func minimumDate(for calendar: FSCalendar) -> Date {
            return Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
        }
        
        func maximumDate(for calendar: FSCalendar) -> Date {
            return Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()
        }
    }
}


#Preview {
    ContentView()
}
