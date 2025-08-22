//
//  TrainingVaultRowView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import SwiftUI

struct TrainingVaultRowView: View {
    let workout: HICWorkoutInstruction
    
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.red)
                .frame(width: 28, height: 28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(workoutPreview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Text("\(workout.number)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(8)
        }
        .padding(.vertical, 4)
    }
    
    private var workoutPreview: String {
        let firstFewInstructions = workout.instructions.prefix(3).joined(separator: " • ")
        return firstFewInstructions.isEmpty ? "High intensity cardio workout" : firstFewInstructions
    }
}

#Preview {
    TrainingVaultRowView(workout: HICWorkoutInstruction(
        number: 1,
        title: "Connaught Range 10-to-1s",
        instructions: ["10 burpees", "100m sprint", "9 burpees", "100m sprint", "… to 1 burpee"]
    ))
}
