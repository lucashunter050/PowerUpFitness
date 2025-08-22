//
//  AddWorkoutView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/20/25.
//

import SwiftUI
import SwiftData

enum WorkoutCategory: String, CaseIterable, Hashable {
    case strength = "Strength"
    case endurance = "Endurance"
    case highIntensityCardio = "High Intensity Cardio"
}

struct AddWorkoutView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedWorkoutCategory: WorkoutCategory = .strength
    @State private var selectedDate: Date = Date()
    @State private var time: Date = Date()
    
    // Child view references to get their data
    @StateObject private var strengthWorkoutData = StrengthWorkoutData()
    @StateObject private var enduranceWorkoutData = EnduranceWorkoutData()
    @StateObject private var hicWorkoutData = HICWorkoutData()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
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

                // Workout Details
                switch selectedWorkoutCategory {
                case .strength:
                    AddStrengthWorkoutView(workoutData: strengthWorkoutData)
                case .endurance:
                    AddEnduranceWorkoutView(workoutData: enduranceWorkoutData)
                case .highIntensityCardio:
                    AddHighIntensityCardioView(workoutData: hicWorkoutData)
                }
                
                VStack(spacing: 16) {
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                }
                .padding(.horizontal)

                // Save Button
                Button(action: {
                    saveWorkout()
                }) {
                    Text("Save Workout")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.top)
        }
        .navigationTitle("Add Workout")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func saveWorkout() {
        let workoutDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: time),
                                               minute: Calendar.current.component(.minute, from: time),
                                               second: 0,
                                               of: selectedDate) ?? selectedDate
        
        switch selectedWorkoutCategory {
        case .strength:
            let workout = StrengthWorkout(
                name: strengthWorkoutData.workoutName.isEmpty ? "Strength Workout" : strengthWorkoutData.workoutName,
                date: workoutDate,
                exercises: strengthWorkoutData.exercises.compactMap { exerciseData in
                    guard !exerciseData.exercise.isEmpty else { return nil }
                    // Take the first set's data as representative (could be enhanced later)
                    let firstSet = exerciseData.sets.first ?? StrengthWorkoutData.ExerciseSet()
                    return Exercise(
                        name: exerciseData.exercise,
                        sets: exerciseData.sets.count,
                        reps: Int(firstSet.reps) ?? 0,
                        weight: Double(firstSet.weight) ?? 0.0
                    )
                }
            )
            modelContext.insert(workout)
            
        case .endurance:
            let workout = EnduranceWorkout(
                cardioMethod: enduranceWorkoutData.selectedCardioMethod.rawValue,
                customCardioMethod: enduranceWorkoutData.customCardioMethod.isEmpty ? nil : enduranceWorkoutData.customCardioMethod,
                date: workoutDate,
                duration: Int(enduranceWorkoutData.duration),
                heartRate: Int(enduranceWorkoutData.heartRate),
                distance: enduranceWorkoutData.distance.isEmpty ? nil : Double(enduranceWorkoutData.distance),
                distanceUnit: enduranceWorkoutData.distanceUnit.rawValue
            )
            modelContext.insert(workout)
            
        case .highIntensityCardio:
            let workout = HighIntensityCardioWorkout(
                date: workoutDate,
                presetName: hicWorkoutData.selectedPreset,
                duration: Int(hicWorkoutData.duration),
                notes: hicWorkoutData.notes.isEmpty ? nil : hicWorkoutData.notes
            )
            modelContext.insert(workout)
        }
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save workout: \(error)")
        }
    }
}

// MARK: - Data Classes for Child Views
class StrengthWorkoutData: ObservableObject {
    @Published var workoutName: String = ""
    @Published var exercises: [StrengthExerciseData] = [StrengthExerciseData()]
    
    struct StrengthExerciseData: Identifiable, Hashable {
        let id = UUID()
        var category: String = ""
        var exercise: String = ""
        var sets: [ExerciseSet] = [ExerciseSet()]
    }
    
    struct ExerciseSet: Identifiable, Hashable {
        let id = UUID()
        var reps: String = ""
        var weight: String = ""
    }
}

class EnduranceWorkoutData: ObservableObject {
    @Published var selectedCardioMethod: CardioMethod = .running
    @Published var customCardioMethod: String = ""
    @Published var duration: Double = 30
    @Published var heartRate: Double = 120
    @Published var distance: String = ""
    @Published var distanceUnit: DistanceUnit = .miles
}

class HICWorkoutData: ObservableObject {
    @Published var selectedPreset: String = ""
    @Published var duration: Double = 10
    @Published var notes: String = ""
}

#Preview {
    AddWorkoutView()
}
