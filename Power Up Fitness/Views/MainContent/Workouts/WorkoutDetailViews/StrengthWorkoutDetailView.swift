//
//  StrengthWorkoutDetailView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI

struct StrengthWorkoutDetailView: View {
    let workout: StrengthWorkout
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "dumbbell.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(workout.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Strength Workout")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    
                    // Date and Summary
                    HStack {
                        Label(formattedDate, systemImage: "calendar")
                        Spacer()
                        Label("\(workout.exercises.count) exercises", systemImage: "list.bullet")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Exercises Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Exercises")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    ForEach(Array(workout.exercises.enumerated()), id: \.element.name) { index, exercise in
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("\(index + 1).")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .frame(width: 20, alignment: .leading)
                                
                                Text(exercise.name)
                                    .font(.headline)
                                    .fontWeight(.medium)
                                
                                Spacer()
                            }
                            
                            // Exercise Details
                            HStack(spacing: 20) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Sets")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                        .textCase(.uppercase)
                                    Text("\(exercise.sets)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Reps")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                        .textCase(.uppercase)
                                    Text("\(exercise.reps)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.green)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Weight")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                        .textCase(.uppercase)
                                    Text(exercise.weight > 0 ? "\(Int(exercise.weight)) lbs" : "Bodyweight")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.orange)
                                }
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(workout.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: workout.date)
    }
}

#Preview {
    NavigationView {
        StrengthWorkoutDetailView(workout: StrengthWorkout(
            name: "Upper Body Power",
            date: Date(),
            exercises: [
                Exercise(name: "Barbell Bench Press", sets: 4, reps: 6, weight: 225.0),
                Exercise(name: "Weighted Pull-ups", sets: 3, reps: 8, weight: 45.0),
                Exercise(name: "Overhead Press", sets: 3, reps: 10, weight: 135.0),
                Exercise(name: "Push-ups", sets: 2, reps: 15, weight: 0.0)
            ]
        ))
    }
}
