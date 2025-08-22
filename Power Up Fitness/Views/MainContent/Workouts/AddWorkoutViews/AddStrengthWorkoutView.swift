//
//  AddStrengthWorkoutView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/20/25.
//

import SwiftUI

// MARK: - Data Models
struct ExerciseSet: Identifiable, Hashable {
    let id = UUID()
    var reps: String = ""
    var weight: String = ""
}

struct StrengthExercise: Identifiable, Hashable {
    let id = UUID()
    var category: String = ""
    var exercise: String = ""
    var sets: [ExerciseSet] = [ExerciseSet()]
}

struct ExerciseDatabase {
    let categories: [String: [String]]
    
    var categoryNames: [String] {
        Array(categories.keys).sorted()
    }
    
    func exercises(for category: String) -> [String] {
        categories[category] ?? []
    }
}



struct AddStrengthWorkoutView: View {
    @ObservedObject var workoutData: StrengthWorkoutData
    @State private var exerciseDatabase: ExerciseDatabase?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Exercises List
                ForEach(Array(workoutData.exercises.enumerated()), id: \.element.id) { index, exercise in
                    VStack(alignment: .leading, spacing: 12) {
                        // Exercise Selection
                        HStack {
                            // Category Picker
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Category")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Picker("Category", selection: $workoutData.exercises[index].category) {
                                    Text("Select").tag("")
                                    if let database = exerciseDatabase {
                                        ForEach(database.categoryNames, id: \.self) { category in
                                            Text(category).tag(category)
                                        }
                                    }
                                }
                                .pickerStyle(.menu)
                                .labelsHidden()
                                .onChange(of: workoutData.exercises[index].category) { _ in
                                    workoutData.exercises[index].exercise = ""
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            Spacer()
                            
                            // Exercise Picker (only show if category is selected)
                            if !exercise.category.isEmpty {
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Exercise")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Picker("Exercise", selection: $workoutData.exercises[index].exercise) {
                                        Text("Select").tag("")
                                        if let database = exerciseDatabase {
                                            ForEach(database.exercises(for: exercise.category), id: \.self) { exerciseName in
                                                Text(exerciseName).tag(exerciseName)
                                            }
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .labelsHidden()
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            } else {
                                // empty view for spacing
                                Spacer()
                            }
                        }
                        
                        // Sets and Reps
                        if !exercise.exercise.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Sets")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        workoutData.exercises[index].sets.append(StrengthWorkoutData.ExerciseSet())
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                                
                                ForEach(Array(exercise.sets.enumerated()), id: \.element.id) { setIndex, set in
                                    HStack(spacing: 12) {
                                        Text("\(setIndex + 1)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .frame(width: 20)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Reps")
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                            TextField("0", text: $workoutData.exercises[index].sets[setIndex].reps)
                                                .textFieldStyle(.roundedBorder)
                                                .keyboardType(.numberPad)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Weight (lbs)")
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                            TextField("0", text: $workoutData.exercises[index].sets[setIndex].weight)
                                                .textFieldStyle(.roundedBorder)
                                                .keyboardType(.decimalPad)
                                        }
                                        
                                        if exercise.sets.count > 1 {
                                            Button(action: {
                                                workoutData.exercises[index].sets.remove(at: setIndex)
                                            }) {
                                                Image(systemName: "minus.circle")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6).opacity(0.5))
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                }
                
                // Add Exercise Button
                Button(action: {
                    workoutData.exercises.append(StrengthWorkoutData.StrengthExerciseData())
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Exercise")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .onAppear {
            loadExerciseDatabase()
        }
    }
    
    private func loadExerciseDatabase() {
        guard let url = Bundle.main.url(forResource: "strength-exercises", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load exercise database file")
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let rootObject = json as? [String: Any],
               let maxStrengthLifts = rootObject["Max Strength Lifts"] as? [String: [String]] {
                exerciseDatabase = ExerciseDatabase(categories: maxStrengthLifts)
            } else {
                print("Invalid JSON structure")
            }
        } catch {
            print("Failed to decode exercise database: \(error)")
        }
    }
}

#Preview {
    AddStrengthWorkoutView(workoutData: StrengthWorkoutData())
}
