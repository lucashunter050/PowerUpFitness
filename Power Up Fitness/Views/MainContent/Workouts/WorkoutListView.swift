//
//  WorkoutListView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/17/25.
//

import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \StrengthWorkout.date, order: .reverse) private var strengthWorkouts: [StrengthWorkout]
    @Query(sort: \EnduranceWorkout.date, order: .reverse) private var enduranceWorkouts: [EnduranceWorkout]
    @Query(sort: \HighIntensityCardioWorkout.date, order: .reverse) private var hicWorkouts: [HighIntensityCardioWorkout]
    
    @State private var showingAddWorkout = false
    
    private var allWorkouts: [WorkoutType] {
        var workouts: [WorkoutType] = []
        workouts.append(contentsOf: strengthWorkouts.map { .strength($0) })
        workouts.append(contentsOf: enduranceWorkouts.map { .endurance($0) })
        workouts.append(contentsOf: hicWorkouts.map { .highIntensityCardio($0) })
        return workouts.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        VStack(spacing: 0) {
                if allWorkouts.isEmpty {
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
                    List(allWorkouts, id: \.id) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            WorkoutRowView(workout: workout)
                        }
                        .swipeActions(edge: .trailing) {
                            Button("Delete", role: .destructive) {
                                deleteWorkout(workout)
                            }
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
    
    private func deleteWorkout(_ workout: WorkoutType) {
        switch workout {
        case .strength(let strengthWorkout):
            modelContext.delete(strengthWorkout)
        case .endurance(let enduranceWorkout):
            modelContext.delete(enduranceWorkout)
        case .highIntensityCardio(let hicWorkout):
            modelContext.delete(hicWorkout)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete workout: \(error)")
        }
    }
}

#Preview {
    WorkoutListView()
}
