//
//  CalendarVIew.swift
//  WorkoutTracker
//
//  Created by Timur on 6/11/24.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date
    @Binding var isExpanded: Bool
    let calendar = FSCalendar()
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        calendar.scope = .week
        
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.weekdayTextColor = .gray
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.selectionColor = .blue
        calendar.appearance.todayColor = .red
        calendar.appearance.todaySelectionColor = .blue
        
        
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        if isExpanded {
            uiView.scope = .month
        } else {
            uiView.scope = .week
        }
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarView
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
    }
}
