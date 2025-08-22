//
//  EnduranceWorkoutDetailView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI

struct EnduranceWorkoutDetailView: View {
    let workout: EnduranceWorkout
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "figure.run")
                            .font(.system(size: 28))
                            .foregroundColor(.green)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(workoutTitle)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Endurance Workout")
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
                            color: .blue
                        )
                        
                        // Heart Rate
                        MetricCard(
                            icon: "heart.fill",
                            title: "Avg Heart Rate",
                            value: "\(workout.heartRate) BPM",
                            color: .red
                        )
                        
                        // Distance (if available)
                        if let distance = workout.distance, distance > 0 {
                            MetricCard(
                                icon: "location",
                                title: "Distance",
                                value: "\(String(format: "%.1f", distance)) \(workout.distanceUnit ?? "mi")",
                                color: .orange
                            )
                        }
                        
                        // Cardio Method
                        MetricCard(
                            icon: getCardioIcon(),
                            title: "Activity",
                            value: workout.cardioMethod,
                            color: .purple
                        )
                    }
                }
                
                // Custom Method (if applicable)
                if let customMethod = workout.customCardioMethod, !customMethod.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom Activity")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(customMethod)
                            .font(.body)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(workoutTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var workoutTitle: String {
        if let customMethod = workout.customCardioMethod, !customMethod.isEmpty {
            return customMethod
        }
        return workout.cardioMethod
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: workout.date)
    }
    
    private func getCardioIcon() -> String {
        switch workout.cardioMethod.lowercased() {
        case "running":
            return "figure.run"
        case "cycling":
            return "bicycle"
        case "swimming":
            return "figure.pool.swim"
        case "walking":
            return "figure.walk"
        case "elliptical":
            return "oval"
        case "rowing":
            return "figure.rower"
        default:
            return "heart.circle"
        }
    }
}

// MARK: - Metric Card Component
struct MetricCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    NavigationView {
        EnduranceWorkoutDetailView(workout: EnduranceWorkout(
            cardioMethod: "Running",
            customCardioMethod: nil,
            date: Date(),
            duration: 45,
            heartRate: 150,
            distance: 5.2,
            distanceUnit: "mi"
        ))
    }
}
