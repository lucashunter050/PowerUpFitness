//
//  TrainingVaultListView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI

struct TrainingVaultListView: View {
    @StateObject private var workoutLoader = HICWorkoutLoader()
    @State private var selectedWorkout: HICWorkoutInstruction?
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                if workoutLoader.workouts.isEmpty {
                    ContentUnavailableView(
                        label: {
                            Image(systemName: "folder")
                                .font(.system(size: 48))
                                .foregroundStyle(.secondary)
                            Text("No workouts available")
                                .font(.title2)
                                .fontWeight(.bold)
                        },
                        description: {
                            Text("Check that hicworkouts.txt is included in the app bundle")
                        }
                    )
                    .padding()
                } else {
                    List(workoutLoader.workouts, id: \.id, selection: $selectedWorkout) { workout in
                        NavigationLink(value: workout) {
                            TrainingVaultRowView(workout: workout)
                        }
                    }
                }
            }
            .navigationTitle("Training Vault")
        } detail: {
            if let selectedWorkout = selectedWorkout {
                TrainingVaultDetailView(workout: selectedWorkout)
            } else {
                ContentUnavailableView(
                    label: {
                        Image(systemName: "dumbbell")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        Text("Select a workout")
                            .font(.title2)
                            .fontWeight(.bold)
                    },
                    description: {
                        Text("Choose a workout from the list to view instructions")
                    }
                )
            }
        }
    }
}

#Preview {
    TrainingVaultListView()
}
