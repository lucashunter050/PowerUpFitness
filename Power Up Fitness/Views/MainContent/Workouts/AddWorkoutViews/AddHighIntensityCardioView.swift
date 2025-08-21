//
//  AddHighIntensityCardioView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/20/25.
//

import SwiftUI

struct AddHighIntensityCardioView: View {
    @State private var selectedPreset: String = ""
    @State private var duration: Double = 10 // Default duration in minutes
    @State private var notes: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Workout Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Select Workout Preset")
                    .font(.headline)
                
                Picker("Preset", selection: $selectedPreset) {
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
                    
                    Text("\(Int(duration)) minutes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $duration, in: 1...40, step: 1) {
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
                 
                 TextField("Add workout notes...", text: $notes, axis: .vertical)
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
    AddHighIntensityCardioView()
}
