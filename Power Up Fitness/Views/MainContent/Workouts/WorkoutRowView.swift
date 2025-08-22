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
            Image(systemName: workoutIcon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(workoutIconColor)
                .frame(width: 32, height: 32)
            
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
    
    private var workoutIcon: String {
        switch workout {
        case .strength:
            return "dumbbell.fill"
        case .endurance:
            return "figure.run"
        case .highIntensityCardio:
            return "flame.fill"
        }
    }
    
    private var workoutIconColor: Color {
        switch workout {
        case .strength:
            return .blue
        case .endurance:
            return .green
        case .highIntensityCardio:
            return .red
        }
    }
    
    private var workoutName: String {
        switch workout {
        case .strength(let strengthWorkout):
            return strengthWorkout.name
        case .endurance(let enduranceWorkout):
            return enduranceWorkout.cardioMethod
        case .highIntensityCardio(let hicWorkout):
            return hicWorkout.presetName
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
