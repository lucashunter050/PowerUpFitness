//
//  TrainingVaultDetailView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI

struct TrainingVaultDetailView: View {
    let workout: HICWorkoutInstruction
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(.orange)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(workout.title)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("High Intensity Cardio")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("Workout \(workout.number)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                // Instructions Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Instructions")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(workout.instructions.enumerated()), id: \.offset) { index, instruction in
                            InstructionRow(
                                stepNumber: index + 1,
                                instruction: instruction,
                                isLastStep: index == workout.instructions.count - 1
                            )
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

struct InstructionRow: View {
    let stepNumber: Int
    let instruction: String
    let isLastStep: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Step indicator
            ZStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 24, height: 24)
                
                Text("\(stepNumber)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            
            // Instruction text
            Text(instruction)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(.vertical, 4)
        
        // Connecting line (except for last step)
        if !isLastStep {
            HStack {
                Rectangle()
                    .fill(Color.orange.opacity(0.3))
                    .frame(width: 2, height: 16)
                    .offset(x: 11)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationView {
        TrainingVaultDetailView(workout: HICWorkoutInstruction(
            number: 1,
            title: "Connaught Range 10-to-1s",
            instructions: [
                "10 burpees",
                "100m sprint",
                "9 burpees",
                "100m sprint",
                "… to 1 burpee",
                "Sprint back to the start each time."
            ]
        ))
    }
}
