//
//  WorkoutListView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/17/25.
//

import SwiftUI

struct WorkoutListView: View {
    @State private var showingAddWorkout = false

    // Sample workout data
    let sampleWorkouts: [WorkoutType] = [
        .strength(StrengthWorkout(
            name: "Upper Body Strength",
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
            exercises: [
                Exercise(name: "Bench Press", sets: 3, reps: 8, weight: 185.0),
                Exercise(name: "Pull-ups", sets: 3, reps: 10, weight: 0.0)
            ]
        )),
        .endurance(EnduranceWorkout(
            name: "Morning Run",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            duration: 30
        )),
        .highIntensityCardio(HighIntensityCardioWorkout(
            date: Date(),
            type: .aerobicAnaerobic(HICAerobicAnaerobic(
                preset: .fast5,
                duration: 20,
                notes: "High intensity session"
            ))
        ))
    ]

    let sampleWorkoutsEmpty: [WorkoutType] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if sampleWorkoutsEmpty.isEmpty {
                    ContentUnavailableView(
                        label: {
                            Image(systemName: "dumbbell")
                                .font(.system(size: 48))
                                .foregroundStyle(.secondary)
                            Text("No workouts yet")
                                .font(.title2)
                                .fontWeight(.bold)
                        },
                        description: {
                            Text("Add a workout to get started")
                        }
                    )
                    .padding()
                } else {
                    List(sampleWorkouts, id: \.id) { workout in
                        NavigationLink(destination: WorkoutDetailView()) {
                            WorkoutRowView(workout: workout)
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddWorkout = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView()
            }
        }
    }
}

#Preview {
    WorkoutListView()
}
