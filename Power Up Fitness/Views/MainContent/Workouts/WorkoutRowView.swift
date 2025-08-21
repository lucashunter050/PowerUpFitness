//
//  WorkoutRowView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/17/25.
//

import SwiftUI

struct WorkoutRowView: View {
    let workout: WorkoutType
    
    var body: some View {
        HStack {
            Text(workoutEmoji)
                .font(.system(size: 26))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(workoutName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(workoutType)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(formattedDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private var workoutEmoji: String {
        switch workout {
        case .strength:
            return "🏋️‍♀️"
        case .endurance:
            return "🏃‍♂️"
        case .highIntensityCardio:
            return "🥵"
        }
    }
    
    private var workoutName: String {
        switch workout {
        case .strength(let strengthWorkout):
            return strengthWorkout.name
        case .endurance(let enduranceWorkout):
            return enduranceWorkout.name
        case .highIntensityCardio(let hicWorkout):
            switch hicWorkout.type {
            case .aerobicAnaerobic(let workout):
                return workout.preset.rawValue
            case .generalConditioning(let workout):
                return workout.preset.rawValue
            case .powerDevelopment(let workout):
                return workout.preset.rawValue
            }
        }
    }
    
    private var workoutType: String {
        switch workout {
        case .strength:
            return "Strength"
        case .endurance:
            return "Endurance"
        case .highIntensityCardio:
            return "High Intensity Cardio"
        }
    }
    
    private var formattedDate: String {
        let date: Date
        switch workout {
        case .strength(let strengthWorkout):
            date = strengthWorkout.date
        case .endurance(let enduranceWorkout):
            date = enduranceWorkout.date
        case .highIntensityCardio(let hicWorkout):
            date = hicWorkout.date
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    WorkoutRowView(workout: .strength(StrengthWorkout(
        name: "Sample Strength Workout",
        date: Date(),
        exercises: []
    )))
}
