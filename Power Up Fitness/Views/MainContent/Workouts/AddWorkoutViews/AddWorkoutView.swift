//
//  AddWorkoutView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/20/25.
//

import SwiftUI

enum WorkoutCategory: String, CaseIterable, Hashable {
    case strength = "Strength"
    case endurance = "Endurance"
    case highIntensityCardio = "High Intensity Cardio"
}

struct AddWorkoutView: View {
    @State private var selectedWorkoutCategory: WorkoutCategory = .strength
    @State private var selectedDate: Date = Date()
    @State private var time: Date = Date()

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Add Workout")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)

            // Workout Type Selection
            HStack {
                Text("Workout Type")
                    .font(.headline)
                
                Spacer()
                
                Picker("Workout Type", selection: $selectedWorkoutCategory) {
                    ForEach(WorkoutCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            .padding(.horizontal)
            .padding(.vertical)

            // Workout Details
            switch selectedWorkoutCategory {
            case .strength:
                AddStrengthWorkoutView()
            case .endurance:
                AddEnduranceWorkoutView()
            case .highIntensityCardio:
                AddHighIntensityCardioView()
            }
            
            HStack {
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
            }
            .padding(.horizontal)
            .padding(.vertical)

            // Save Button
            Button(action: {
                // Save workout
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    AddWorkoutView()
}
