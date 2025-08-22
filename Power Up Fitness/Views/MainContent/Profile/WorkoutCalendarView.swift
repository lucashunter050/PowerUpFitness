//
//  WorkoutCalendarView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI
import SwiftData

struct WorkoutCalendarView: View {
    @Query private var strengthWorkouts: [StrengthWorkout]
    @Query private var enduranceWorkouts: [EnduranceWorkout]
    @Query private var hicWorkouts: [HighIntensityCardioWorkout]
    
    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 16) {
            // Month/Year picker
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text(dateFormatter.string(from: currentMonth))
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                // Weekday headers
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .frame(height: 30)
                }
                
                // Calendar days
                ForEach(calendarDays, id: \.self) { date in
                    CalendarDayView(
                        date: date,
                        workoutTypes: getWorkoutTypes(for: date),
                        isCurrentMonth: calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
                    )
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var calendarDays: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth) else {
            return []
        }
        
        let monthStart = monthInterval.start
        let monthEnd = monthInterval.end
        
        // Find the first Sunday before or on the month start
        let startWeekday = calendar.component(.weekday, from: monthStart)
        let startDate = calendar.date(byAdding: .day, value: -(startWeekday - 1), to: monthStart)!
        
        // Generate dates for the calendar grid
        var dates: [Date] = []
        var currentDate = startDate
        
        // Generate 6 weeks worth of dates (42 days)
        for _ in 0..<42 {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    private func previousMonth() {
        currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
    }
    
    private func nextMonth() {
        currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
    }
    
    private func getWorkoutTypes(for date: Date) -> Set<CalendarWorkoutType> {
        var workoutTypes: Set<CalendarWorkoutType> = []
        
        // Check strength workouts
        for workout in strengthWorkouts {
            if calendar.isDate(workout.date, inSameDayAs: date) {
                workoutTypes.insert(.strength)
                break
            }
        }
        
        // Check endurance workouts
        for workout in enduranceWorkouts {
            if calendar.isDate(workout.date, inSameDayAs: date) {
                workoutTypes.insert(.endurance)
                break
            }
        }
        
        // Check HIC workouts
        for workout in hicWorkouts {
            if calendar.isDate(workout.date, inSameDayAs: date) {
                workoutTypes.insert(.highIntensityCardio)
                break
            }
        }
        
        return workoutTypes
    }
}

enum CalendarWorkoutType: CaseIterable {
    case strength, endurance, highIntensityCardio
    
    var color: Color {
        switch self {
        case .strength: return .blue
        case .endurance: return .green
        case .highIntensityCardio: return .red
        }
    }
}

struct CalendarDayView: View {
    let date: Date
    let workoutTypes: Set<CalendarWorkoutType>
    let isCurrentMonth: Bool
    
    private let calendar = Calendar.current
    
    var body: some View {
        ZStack {
            // Workout indicators (background layer)
            if !workoutTypes.isEmpty {
                WorkoutIndicatorView(workoutTypes: workoutTypes)
            }
            
            // Day number (foreground layer - always on top)
            Text("\(calendar.component(.day, from: date))")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(textColor)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 0)
        }
        .frame(width: 40, height: 40)
    }
    
    private var textColor: Color {
        if !workoutTypes.isEmpty {
            return .white // White text when there are workout indicators
        } else {
            return isCurrentMonth ? .primary : .secondary
        }
    }
}

struct WorkoutIndicatorView: View {
    let workoutTypes: Set<CalendarWorkoutType>
    
    var body: some View {
        ZStack {
            // Create background circle that fills the cell
            Circle()
                .fill(primaryWorkoutColor.opacity(0.8))
                .frame(width: 36, height: 36)
            
            // Add rings for additional workout types
            if workoutTypes.contains(.strength) && workoutTypes.count > 1 {
                Circle()
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 24, height: 24)
            }
            
            if workoutTypes.contains(.highIntensityCardio) && 
               (workoutTypes.contains(.strength) || workoutTypes.contains(.endurance)) {
                Circle()
                    .stroke(Color.red, lineWidth: 3)
                    .frame(width: workoutTypes.contains(.strength) && workoutTypes.contains(.endurance) ? 30 : 28, 
                           height: workoutTypes.contains(.strength) && workoutTypes.contains(.endurance) ? 30 : 28)
            }
            
            if workoutTypes.contains(.endurance) && workoutTypes.count > 1 {
                Circle()
                    .stroke(Color.green, lineWidth: 3)
                    .frame(width: 34, height: 34)
            }
        }
    }
    
    private var primaryWorkoutColor: Color {
        // Priority: strength > endurance > HIC for the fill color
        if workoutTypes.contains(.strength) {
            return .blue
        } else if workoutTypes.contains(.endurance) {
            return .green
        } else {
            return .red
        }
    }
}

#Preview {
    WorkoutCalendarView()
}
