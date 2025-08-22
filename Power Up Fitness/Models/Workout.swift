//
//  Workout.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/17/25.
//

import Foundation
import SwiftData

enum WorkoutType: Identifiable, Hashable {
    case strength(StrengthWorkout)
    case endurance(EnduranceWorkout)
    case highIntensityCardio(HighIntensityCardioWorkout)
    
    var id: UUID {
        switch self {
        case .strength(let workout):
            return workout.id
        case .endurance(let workout):
            return workout.id
        case .highIntensityCardio(let workout):
            return workout.id
        }
    }
    
    var date: Date {
        switch self {
        case .strength(let workout):
            return workout.date
        case .endurance(let workout):
            return workout.date
        case .highIntensityCardio(let workout):
            return workout.date
        }
    }
    
    var title: String {
        switch self {
        case .strength(let workout):
            return workout.name
        case .endurance(let workout):
            return workout.cardioMethod
        case .highIntensityCardio(let workout):
            return workout.presetName
        }
    }
}

@Model
class StrengthWorkout: Identifiable {
    var id = UUID()
    var name: String
    var date: Date
    var exercises: [Exercise]
    
    init(name: String, date: Date, exercises: [Exercise]) {
        self.name = name
        self.date = date
        self.exercises = exercises
    }
}

@Model
class Exercise {
    var name: String
    var sets: Int
    var reps: Int
    var weight: Double
    
    init(name: String, sets: Int, reps: Int, weight: Double) {
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}

@Model
class EnduranceWorkout: Identifiable {
    var id = UUID()
    var cardioMethod: String
    var customCardioMethod: String?
    var date: Date
    var duration: Int // in minutes
    var heartRate: Int
    var distance: Double?
    var distanceUnit: String?
    
    init(cardioMethod: String, customCardioMethod: String? = nil, date: Date, duration: Int, heartRate: Int, distance: Double? = nil, distanceUnit: String? = nil) {
        self.cardioMethod = cardioMethod
        self.customCardioMethod = customCardioMethod
        self.date = date
        self.duration = duration
        self.heartRate = heartRate
        self.distance = distance
        self.distanceUnit = distanceUnit
    }
}

@Model
class HighIntensityCardioWorkout: Identifiable {
    var id = UUID()
    var date: Date
    var presetName: String
    var duration: Int
    var notes: String?
    
    init(date: Date, presetName: String, duration: Int, notes: String? = nil) {
        self.date = date
        self.presetName = presetName
        self.duration = duration
        self.notes = notes
    }
}

enum HICWorkoutType: Identifiable, Codable, Hashable {
    case aerobicAnaerobic(HICAerobicAnaerobic)
    case generalConditioning(HICGeneralConditioning)
    case powerDevelopment(HICPowerDevelopment)
    
    var id: UUID {
        switch self {
        case .aerobicAnaerobic(let workout):
            return workout.id
        case .generalConditioning(let workout):
            return workout.id
        case .powerDevelopment(let workout):
            return workout.id
        }
    }
    
    static func getPresetFromName(_ name: String) -> HICWorkoutType? {
        if let aerobicPreset = HICAerobicAnaerobicPreset(rawValue: name) {
            return .aerobicAnaerobic(HICAerobicAnaerobic(preset: aerobicPreset, duration: nil, notes: nil))
        }
        if let conditioningPreset = HICGeneralConditioningPreset(rawValue: name) {
            return .generalConditioning(HICGeneralConditioning(preset: conditioningPreset, duration: nil, notes: nil))
        }
        if let powerPreset = HICPowerDevelopmentPreset(rawValue: name) {
            return .powerDevelopment(HICPowerDevelopment(preset: powerPreset, duration: nil, notes: nil))
        }
        return nil
    }
}

struct HICAerobicAnaerobic: Identifiable, Codable, Hashable {
    let id = UUID()
    var preset: HICAerobicAnaerobicPreset
    var duration: Int? // in minutes
    var notes: String?
}

struct HICGeneralConditioning: Identifiable, Codable, Hashable {
    let id = UUID()
    var preset: HICGeneralConditioningPreset
    var duration: Int? // in minutes
    var notes: String?
}

struct HICPowerDevelopment: Identifiable, Codable, Hashable {
    let id = UUID()
    var preset: HICPowerDevelopmentPreset
    var duration: Int? // in minutes
    var notes: String?
}

enum HICAerobicAnaerobicPreset: String, Codable, CaseIterable {
    case connaughtRange10to1s = "Connaught Range 10 to 1s"
    case fast5 = "Fast 5"
    case sixHundredMResets = "600M Resets"
    case heavyBagResets = "Heavy Bag Resets"
    case indoorPowerIntervals = "Indoor Power Intervals"
    case sledgeDrill = "Sledge Drill"
    case boo = "BOO"
    case booII = "BOO II"
    case fobbitIntervals = "Fobbit Intervals"
    case shortHills = "Short Hills"
    case oxygenDebt101 = "Oxygen Debt 101"
    case speedEnduranceLadders = "Speed-Endurance Ladders"
    case meatEater = "Meat Eater"
    case meatEaterII = "Meat Eater II"
    case disarmed = "Disarmed"
    case standardIssueHills = "Standard Issue Hills"
    case apexHills = "Apex Hills"
    case bloodyLungs = "Bloody Lungs"
    case bloodyLungsII = "Bloody Lungs II"
    case anaerobicCapacity = "Anaerobic Capacity"
    case pepperPot = "Pepper Pot"
    case buffaloLaps = "Buffalo Laps"
    case meatEaterIII = "Meat Eater III"
    case devilsTrinity = "Devil's Trinity - Combat Conditioning Circuit"
}

enum HICGeneralConditioningPreset: String, Codable, CaseIterable {
    case gc1BeatYourFace = "GC# 1 aka Beat Your Face"
    case gc2 = "GC# 2"
    case gc3BrigRat = "GC# 3 aka Brig Rat"
    case gc4 = "GC# 4"
    case gc5 = "GC #5"
    case gc6 = "GC #6"
    case gc7 = "GC #7"
    case gc8 = "GC #8"
    case gc9 = "GC #9"
    case gc10 = "GC #10"
    case gc11OutsideTheWire = "GC #11 aka Outside the Wire"
    case gc12 = "GC #12"
}

enum HICPowerDevelopmentPreset: String, Codable, CaseIterable {
    case bwPlyometricPower = "BW Plyometric Power"
    case powerComplex = "Power Complex"
    case kineticConditioning = "Kinetic Conditioning"
    case transitionComplex = "Transition Complex"
}