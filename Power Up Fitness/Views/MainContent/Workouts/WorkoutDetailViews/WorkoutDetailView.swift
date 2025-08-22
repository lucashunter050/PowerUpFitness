//
//  WorkoutDetailView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/17/25.
//

import SwiftUI

struct WorkoutDetailView: View {
    let workout: WorkoutType
    
    var body: some View {
        switch workout {
        case .strength(let strengthWorkout):
            StrengthWorkoutDetailView(workout: strengthWorkout)
        case .endurance(let enduranceWorkout):
            EnduranceWorkoutDetailView(workout: enduranceWorkout)
        case .highIntensityCardio(let hicWorkout):
            HICWorkoutDetailView(workout: hicWorkout)
        }
    }
}

#Preview {
    WorkoutDetailView(workout: .strength(StrengthWorkout(
        name: "Sample Strength Workout",
        date: Date(),
        exercises: [
            Exercise(name: "Bench Press", sets: 3, reps: 8, weight: 185.0),
            Exercise(name: "Pull-ups", sets: 3, reps: 10, weight: 0.0)
        ]
    )))
}
