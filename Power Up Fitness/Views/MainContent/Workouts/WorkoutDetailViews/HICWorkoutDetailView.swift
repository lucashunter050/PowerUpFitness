//
//  HICWorkoutDetailView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI

struct HICWorkoutDetailView: View {
    let workout: HighIntensityCardioWorkout
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.red)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(workout.presetName)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("High Intensity Cardio")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    
                    // Date
                    HStack {
                        Label(formattedDate, systemImage: "calendar")
                        Spacer()
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Workout Metrics
                VStack(alignment: .leading, spacing: 16) {
                    Text("Workout Details")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        // Duration
                        MetricCard(
                            icon: "timer",
                            title: "Duration",
                            value: "\(workout.duration) min",
                            color: .orange
                        )
                        
                        // Intensity
                        MetricCard(
                            icon: "bolt.fill",
                            title: "Intensity",
                            value: getIntensityLevel(),
                            color: .red
                        )
                        
                        // Workout Type
                        MetricCard(
                            icon: "target",
                            title: "Category",
                            value: getWorkoutCategory(),
                            color: .purple
                        )
                        
                        // Preset
                        MetricCard(
                            icon: "list.bullet.circle",
                            title: "Preset",
                            value: workout.presetName,
                            color: .blue
                        )
                    }
                }
                
                // Notes Section (if available)
                if let notes = workout.notes, !notes.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Workout Notes")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(notes)
                            .font(.body)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                
                // Preset Description
                VStack(alignment: .leading, spacing: 12) {
                    Text("About This Workout")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(getPresetDescription())
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(workout.presetName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: workout.date)
    }
    
    private func getIntensityLevel() -> String {
        if workout.duration <= 15 {
            return "Max"
        } else if workout.duration <= 25 {
            return "High"
        } else {
            return "Moderate"
        }
    }
    
    private func getWorkoutCategory() -> String {
        let presetName = workout.presetName.lowercased()
        
        // Check for Aerobic/Anaerobic patterns
        if presetName.contains("oxygen") || presetName.contains("endurance") || 
           presetName.contains("interval") || presetName.contains("reset") ||
           presetName.contains("hills") || presetName.contains("lungs") {
            return "Aerobic/Anaerobic"
        }
        
        // Check for General Conditioning patterns
        if presetName.contains("gc") || presetName.contains("beat") || 
           presetName.contains("brig") || presetName.contains("wire") {
            return "General Conditioning"
        }
        
        // Check for Power Development patterns
        if presetName.contains("power") || presetName.contains("plyometric") ||
           presetName.contains("kinetic") || presetName.contains("transition") {
            return "Power Development"
        }
        
        return "High Intensity"
    }
    
    private func getPresetDescription() -> String {
        let category = getWorkoutCategory()
        
        switch category {
        case "Aerobic/Anaerobic":
            return "This workout targets both aerobic and anaerobic energy systems, improving cardiovascular endurance and power output through high-intensity intervals."
        case "General Conditioning":
            return "A comprehensive conditioning workout designed to improve overall fitness, combining cardiovascular endurance with functional strength movements."
        case "Power Development":
            return "Focused on developing explosive power and speed through plyometric movements and high-intensity exercises that target fast-twitch muscle fibers."
        default:
            return "A high-intensity cardio workout designed to push your limits and improve cardiovascular fitness in a short amount of time."
        }
    }
}

#Preview {
    NavigationView {
        HICWorkoutDetailView(workout: HighIntensityCardioWorkout(
            date: Date(),
            presetName: "Fast 5",
            duration: 20,
            notes: "Pushed hard on the final rounds. Felt great!"
        ))
    }
}
