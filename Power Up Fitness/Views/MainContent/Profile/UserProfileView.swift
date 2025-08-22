//
//  UserProfileView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI
import SwiftData

struct UserProfileView: View {
    @Query(sort: \StrengthWorkout.date, order: .reverse) private var strengthWorkouts: [StrengthWorkout]
    @Query(sort: \EnduranceWorkout.date, order: .reverse) private var enduranceWorkouts: [EnduranceWorkout]
    @Query(sort: \HighIntensityCardioWorkout.date, order: .reverse) private var hicWorkouts: [HighIntensityCardioWorkout]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Header
                VStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("My Profile")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Workout Statistics")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Workout Statistics
                VStack(spacing: 16) {
                    Text("Workout Summary")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        WorkoutStatCard(
                            title: "Strength",
                            count: strengthWorkouts.count,
                            daysSinceLastWorkout: daysSinceLastWorkout(for: strengthWorkouts.first?.date),
                            icon: "dumbbell.fill",
                            color: .blue
                        )
                        
                        WorkoutStatCard(
                            title: "Endurance",
                            count: enduranceWorkouts.count,
                            daysSinceLastWorkout: daysSinceLastWorkout(for: enduranceWorkouts.first?.date),
                            icon: "figure.run",
                            color: .green
                        )
                        
                        WorkoutStatCard(
                            title: "High Intensity",
                            count: hicWorkouts.count,
                            daysSinceLastWorkout: daysSinceLastWorkout(for: hicWorkouts.first?.date),
                            icon: "flame.fill",
                            color: .red
                        )
                        
                        WorkoutStatCard(
                            title: "Total",
                            count: totalWorkouts,
                            daysSinceLastWorkout: daysSinceLastWorkout(for: mostRecentWorkoutDate),
                            icon: "chart.bar.fill",
                            color: .orange
                        )
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                // Workout Calendar
                VStack(spacing: 16) {
                    Text("Workout Calendar")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    WorkoutCalendarView()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationTitle("Profile")
        .background(Color(.systemGroupedBackground))
    }
    
    private var totalWorkouts: Int {
        strengthWorkouts.count + enduranceWorkouts.count + hicWorkouts.count
    }
    
    private var mostRecentWorkoutDate: Date? {
        let allDates = [
            strengthWorkouts.first?.date,
            enduranceWorkouts.first?.date,
            hicWorkouts.first?.date
        ].compactMap { $0 }
        
        return allDates.max()
    }
    
    private func daysSinceLastWorkout(for date: Date?) -> Int? {
        guard let date = date else { return nil }
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: date, to: now)
        return components.day
    }
}

struct WorkoutStatCard: View {
    let title: String
    let count: Int
    let daysSinceLastWorkout: Int?
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(color)
                
                Spacer()
                
                Text("\(count)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let days = daysSinceLastWorkout {
                    if days == 0 {
                        Text("Today")
                            .font(.caption)
                            .foregroundColor(.green)
                    } else if days == 1 {
                        Text("Yesterday")
                            .font(.caption)
                            .foregroundColor(.orange)
                    } else {
                        Text("\(days) days ago")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text("No workouts yet")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationView {
        UserProfileView()
    }
}
