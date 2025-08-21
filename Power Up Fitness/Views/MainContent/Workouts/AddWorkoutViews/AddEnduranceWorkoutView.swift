//
//  AddEnduranceWorkoutView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/20/25.
//

import SwiftUI

enum CardioMethod: String, CaseIterable, Hashable {
    case running = "Running"
    case cycling = "Cycling"
    case swimming = "Swimming"
    case walking = "Walking"
    case elliptical = "Elliptical"
    case rowing = "Rowing"
    case other = "Other"
}

struct AddEnduranceWorkoutView: View {
    @State private var selectedCardioMethod: CardioMethod = .running
    @State private var customCardioMethod: String = ""
    @State private var duration: Double = 30 // Duration in minutes
    @State private var heartRate: Double = 120 // Heart rate in BPM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Cardio Method Selection
            VStack(alignment: .leading, spacing: 8) {

                HStack {    
                    Text("Cardio Method")
                        .font(.headline)
                    
                    Spacer()
                    
                    Picker("Cardio Method", selection: $selectedCardioMethod) {
                        ForEach(CardioMethod.allCases, id: \.self) { method in
                            Text(method.rawValue).tag(method)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    
                }

                
                // Custom input field for "Other" option
                if selectedCardioMethod == .other {
                    TextField("Enter cardio method", text: $customCardioMethod)
                        .transition(.opacity.combined(with: .slide))
                }
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
                
                Slider(value: $duration, in: 1...120, step: 1) {
                    Text("Duration")
                } minimumValueLabel: {
                    Text("1m")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } maximumValueLabel: {
                    Text("120m+")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .accentColor(.blue)
            }
            
            // Heart Rate Gauge
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Heart Rate")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(Int(heartRate)) BPM")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Custom gauge-style slider
                VStack(spacing: 4) {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Background track
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 12)
                            
                            // Filled track with gradient
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.green,
                                        Color.yellow,
                                        Color.orange,
                                        Color.red
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .frame(width: (heartRate - 60) / (220 - 60) * geometry.size.width, height: 12)
                            
                            // Draggable heart icon
                            Image(systemName: "heart.fill")
                                .foregroundColor(getHeartColor(for: heartRate))
                                .font(.system(size: 20, weight: .bold))
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 28, height: 28)
                                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 1)
                                )
                                .offset(x: (heartRate - 60) / (220 - 60) * geometry.size.width - 14)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let newValue = 60 + (value.location.x / geometry.size.width) * (220 - 60)
                                            heartRate = min(max(newValue, 60), 220)
                                        }
                                )
                        }
                    }
                    .frame(height: 28)
                    
                    // Heart rate zone indicators
                    HStack {
                        Text("60")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("Resting")
                            .font(.caption2)
                            .foregroundColor(.green)
                            .opacity(heartRate < 100 ? 1.0 : 0.5)
                        
                        Spacer()
                        
                        Text("Moderate")
                            .font(.caption2)
                            .foregroundColor(.yellow)
                            .opacity(heartRate >= 100 && heartRate < 150 ? 1.0 : 0.5)
                        
                        Spacer()
                        
                        Text("Vigorous")
                            .font(.caption2)
                            .foregroundColor(.orange)
                            .opacity(heartRate >= 150 && heartRate < 180 ? 1.0 : 0.5)
                        
                        Spacer()
                        
                        Text("Max")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .opacity(heartRate >= 180 ? 1.0 : 0.5)
                        
                        Spacer()
                        
                        Text("220")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .animation(.easeInOut(duration: 0.3), value: selectedCardioMethod)
    }
    
    // Helper function to get heart color based on heart rate
    private func getHeartColor(for heartRate: Double) -> Color {
        switch heartRate {
        case 60..<100:
            return .green
        case 100..<150:
            return .yellow
        case 150..<180:
            return .orange
        default:
            return .red
        }
    }
}

#Preview {
    AddEnduranceWorkoutView()
}
