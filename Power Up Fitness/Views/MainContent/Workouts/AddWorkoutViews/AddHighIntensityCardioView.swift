//
//  AddHighIntensityCardioView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/20/25.
//

import SwiftUI

struct AddHighIntensityCardioView: View {
    @ObservedObject var workoutData: HICWorkoutData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Workout Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Select Workout Preset")
                    .font(.headline)
                
                Picker("Preset", selection: $workoutData.selectedPreset) {
                    Text("Select").tag("")
                    Section(header: Text("Aerobic/Anaerobic")) {
                        ForEach(HICAerobicAnaerobicPreset.allCases, id: \.self) { preset in
                            Text(preset.rawValue).tag(preset.rawValue)
                        }
                    }
                    
                    Section(header: Text("General Conditioning")) {
                        ForEach(HICGeneralConditioningPreset.allCases, id: \.self) { preset in
                            Text(preset.rawValue).tag(preset.rawValue)
                        }
                    }
                    
                    Section(header: Text("Power Development")) {
                        ForEach(HICPowerDevelopmentPreset.allCases, id: \.self) { preset in
                            Text(preset.rawValue).tag(preset.rawValue)
                        }
                    }
                }
                .pickerStyle(.menu)
            }
            
            // Duration Slider
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Duration")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(Int(workoutData.duration)) minutes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $workoutData.duration, in: 1...40, step: 1) {
                    Text("Duration")
                } minimumValueLabel: {
                    Text("1m")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } maximumValueLabel: {
                    Text("40m")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .accentColor(.blue)
            }

            Divider()
            
                         // Notes
             VStack(alignment: .leading, spacing: 8) {
                 Text("Notes")
                     .font(.headline)
                 
                 TextField("Add workout notes...", text: $workoutData.notes, axis: .vertical)
                     .lineLimit(3...10)
                     .frame(minHeight: 60)
             }
                
                
            Divider()
            
            Spacer()
        }
        .padding()
    }

}

#Preview {
    AddHighIntensityCardioView(workoutData: HICWorkoutData())
}
