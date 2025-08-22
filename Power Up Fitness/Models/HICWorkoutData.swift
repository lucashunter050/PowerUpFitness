//
//  HICWorkoutData.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/21/25.
//

import Foundation

struct HICWorkoutInstruction: Identifiable, Hashable {
    let id = UUID()
    let number: Int
    let title: String
    let instructions: [String]
    
    var formattedTitle: String {
        "\(number). \(title)"
    }
}

class HICWorkoutLoader: ObservableObject {
    @Published var workouts: [HICWorkoutInstruction] = []
    
    init() {
        loadWorkouts()
    }
    
    private func loadWorkouts() {
        workouts = [
            HICWorkoutInstruction(number: 1, title: "Connaught Range 10-to-1s", instructions: [
                "10 burpees", "100m sprint", "9 burpees", "100m sprint", "… to 1 burpee", "Sprint back to the start each time."
            ]),
            HICWorkoutInstruction(number: 2, title: "Fast 5 Tempo Run", instructions: [
                "5km (3 miles) run", "Pace should make conversation difficult."
            ]),
            HICWorkoutInstruction(number: 3, title: "600m Resets", instructions: [
                "600m max effort sprint", "Rest 3-5 minutes", "x6 rounds", "Warm up with a 5-10 minute jog before starting."
            ]),
            HICWorkoutInstruction(number: 4, title: "Heavy Bag Resets", instructions: [
                "90 seconds heavy bag strikes at max effort", "Rest 2-5 minutes", "x5 rounds"
            ]),
            HICWorkoutInstruction(number: 5, title: "Indoor Power Intervals", instructions: [
                "2 minute run, row, or Airdyne at max effort", "Rest 3-5 minutes", "x5 rounds"
            ]),
            HICWorkoutInstruction(number: 6, title: "Sledge Drill", instructions: [
                "Sledgehammer/Tire Strikes for 1 minute", "Jump Rope for 1 minute", "Sledgehammer/Tire Strikes for 30 seconds", "Jump Rope for 30 seconds", "Rest 2-3 minutes", "x5 rounds", "Alternate hands and grip for the sledge strikes."
            ]),
            HICWorkoutInstruction(number: 7, title: "Black on Oxygen (BOO)", instructions: [
                "60 seconds kettlebell swings (or 30 swings)", "800m run", "Rest 2-3 minutes", "x5 rounds"
            ]),
            HICWorkoutInstruction(number: 8, title: "BOO II", instructions: [
                "10 burpees", "800m run", "5 burpees", "400m max effort sprint", "Rest 2-3 minutes", "x3 rounds", "Aim to complete each round as quickly as possible."
            ]),
            HICWorkoutInstruction(number: 9, title: "Fobbit Intervals", instructions: [
                "2 minute run, row, or skip", "20 kettlebell swings", "2 minute run, row, or skip", "10 kettlebell snatches per arm", "Repeat this sequence for 20 minutes."
            ]),
            HICWorkoutInstruction(number: 10, title: "Short Hills", instructions: [
                "Sprint up a hill for 10-15 seconds", "Walk down the hill as your rest", "x10 rounds"
            ]),
            HICWorkoutInstruction(number: 11, title: "Oxygen Debt 101", instructions: [
                "200m max effort sprint", "Rest 30 seconds", "Repeat the sprint two more times", "Rest 3 minutes", "Repeat this sequence for 3-4 rounds."
            ]),
            HICWorkoutInstruction(number: 12, title: "Speed-Endurance Ladders", instructions: [
                "400m sprint", "Rest 40 seconds", "300m sprint", "Rest 30 seconds", "200m sprint", "Rest 20 seconds", "100m sprint", "Rest 10 seconds", "Work your way back up the ladder in reverse."
            ]),
            HICWorkoutInstruction(number: 13, title: "Meat-Eater", instructions: [
                "100m max effort sprint", "20 Russian kettlebell swings", "Walk back to the start", "x10 rounds", "Leave the kettlebell 100m away at the finish line."
            ]),
            HICWorkoutInstruction(number: 14, title: "Meat-Eater II", instructions: [
                "10 Russian kettlebell swings", "10 burpees", "Rest 60 seconds", "x10 rounds", "Complete the entire workout for time."
            ]),
            HICWorkoutInstruction(number: 15, title: "Disarmed", instructions: [
                "10 burpees", "Heavy bag strikes for 2 minutes", "Rest 60 seconds", "x3-5 rounds"
            ]),
            HICWorkoutInstruction(number: 16, title: "Standard Issue Hills", instructions: [
                "5-10 hill sprints", "Rest 1-2 minutes between sprints", "Sprint up a hill that takes 30-45 seconds to ascend. Walk or jog down."
            ]),
            HICWorkoutInstruction(number: 17, title: "Apex Hills", instructions: [
                "Hill sprint", "10 Russian kettlebell swings", "Walk down the hill", "Rest 1-2 minutes", "x5-10 rounds", "Place the kettlebell at the top of the hill. The rest interval starts at the bottom."
            ]),
            HICWorkoutInstruction(number: 18, title: "Bloody Lungs I", instructions: [
                "10 plank push-ups", "Hill sprint", "10 burpees", "Walk down the hill", "x5 rounds", "A plank push-up consists of a plank to an upright plank, one regular push-up, then back to a plank, which counts as one rep."
            ]),
            HICWorkoutInstruction(number: 19, title: "Bloody Lungs II", instructions: [
                "10 burpees", "Hill sprint", "5 kettlebell/dumbbell snatches per arm", "Walk down the hill", "Rest 1-2 minutes", "x5-10 rounds", "Place the kettlebell at the top of the hill."
            ]),
            HICWorkoutInstruction(number: 20, title: "Anaerobic Capacity", instructions: [
                "800m jog", "400m sprint", "800m jog", "400m sprint", "400m jog", "200m sprint", "400m jog", "200m sprint", "Complete this sequence continuously.", "Finisher: 50 plank push-ups."
            ]),
            HICWorkoutInstruction(number: 21, title: "Pepper Potting", instructions: [
                "Carry a 30-50lb rucksack, backpack, or weight vest.", "Set a timer for every 5 minutes.", "Hike or walk a 1.5-mile route.", "Every 5 minutes, run for 100m, stopping every 4th or 5th step to drop to one knee for 2 seconds before continuing."
            ]),
            HICWorkoutInstruction(number: 22, title: "Buffalo Laps", instructions: [
                "10 burpees", "400m run", "10 two-handed kettlebell swings (or 20 one-handed)", "Rest 45-60 seconds", "x4 rounds", "Complete as quickly as possible for time."
            ]),
            HICWorkoutInstruction(number: 23, title: "Meat-Eater III", instructions: [
                "10 double kettlebell clean and press", "300m sprint", "Lunge 100m back to the start", "x4-6 rounds", "Use two kettlebells of equal, moderate weight."
            ]),
            HICWorkoutInstruction(number: 24, title: "Devil's Trinity", instructions: [
                "Kettlebell swings for 1 minute", "Burpees for 1 minute", "Heavy bag strikes for 1 minute", "Rest for 1 minute", "x5 rounds", "Perform each exercise for as many reps as possible in the minute."
            ]),
            HICWorkoutInstruction(number: 25, title: "GC 1 (Beat Your Face)", instructions: [
                "Burpees for 3 minutes", "Rest for 3 minutes", "Burpees for 2 minutes", "Rest for 2 minutes", "Burpees for 1 minute", "Rest for 1 minute", "x1-3 rounds", "Perform as many burpees as possible in the given time."
            ]),
            HICWorkoutInstruction(number: 26, title: "GC 2", instructions: [
                "Pull-ups x10, burpees x10, squat jumps x10, plyometric push-ups x10", "Pull-ups x9, burpees x9, etc.", "Continue this descending ladder to 1 rep.", "Complete the entire workout for time."
            ]),
            HICWorkoutInstruction(number: 27, title: "GC 3 (Brig Rat)", instructions: [
                "Burpees for 30 seconds", "Dips for 30 seconds", "Burpees for 30 seconds", "Squats for 30 seconds", "Burpees for 30 seconds", "Back extensions for 30 seconds", "Rest for 1 minute", "x3-5 rounds", "Use bodyweight for squats. A plank can replace back extensions."
            ]),
            HICWorkoutInstruction(number: 28, title: "GC 4", instructions: [
                "100 pull-ups", "400m run", "100 push-ups", "400m run", "100 kettlebell/dumbbell swings", "400m run", "Complete for time."
            ]),
            HICWorkoutInstruction(number: 29, title: "GC 5", instructions: [
                "A", "Max dips in 1 minute", "Rest 90 seconds", "Max push-ups in 1 minute", "Rest 90 seconds", "x3 rounds", "B", "5 pull-ups", "10 burpees", "x3 rounds", "Complete all of A, then rest 2 minutes before starting B."
            ]),
            HICWorkoutInstruction(number: 30, title: "GC 6", instructions: [
                "Sledgehammer/Tire Strikes x10", "Burpees x5", "Squats x10", "As many rounds as possible in 5 minutes", "Rest 60-90 seconds", "x3 rounds", "Kettlebell or dumbbell swings can be substituted for sledgehammer strikes."
            ]),
            HICWorkoutInstruction(number: 31, title: "GC 7", instructions: [
                "50 burpees", "50 squats", "50 diamond push-ups", "800m run", "x3 rounds", "Complete for time."
            ]),
            HICWorkoutInstruction(number: 32, title: "GC 8", instructions: [
                "A", "10 kettlebell/dumbbell snatches per arm", "25 box jumps", "25 hanging knees to elbow", "25 dips", "5 burpees", "x4 rounds for time", "B", "60 seconds handstand static hold", "Rest 2-3 minutes", "x3 rounds", "Complete A before moving to B."
            ]),
            HICWorkoutInstruction(number: 33, title: "GC 9", instructions: [
                "A", "3 pull-ups", "5 burpees", "10 squats", "Complete as many rounds as possible in 10 minutes.", "B", "10x 100m sprints", "Complete A before moving to B."
            ]),
            HICWorkoutInstruction(number: 34, title: "GC 10", instructions: [
                "A", "2 minute jog", "25 burpees", "x4 rounds", "B", "Core or grip finisher", "The burpees should be completed as quickly as possible."
            ]),
            HICWorkoutInstruction(number: 35, title: "GC 11 (Outside the Wire)", instructions: [
                "A", "100m sprint", "50m bear crawl", "x5 rounds for time", "B", "100 sledgehammer/tire strikes for time", "Complete A and B as quickly as possible."
            ]),
            HICWorkoutInstruction(number: 36, title: "GC 12", instructions: [
                "A", "1.5 mile run for time", "B", "20 barbell push-press", "20 back extensions", "20 pull-ups", "x3 rounds for time", "Use a light weight (15-30% of your 1RM) for the push-press."
            ]),
            HICWorkoutInstruction(number: 37, title: "BW Plyo - Power", instructions: [
                "A", "10 explosive plyometric push-ups", "Rest 90 seconds", "10 explosive jump squats", "Rest 90 seconds", "5-10 explosive plyometric pull-ups", "Rest 2 minutes", "x3 rounds", "B", "5x 50m sprints", "The movements in A should be explosive and crisp."
            ]),
            HICWorkoutInstruction(number: 38, title: "Power Complex", instructions: [
                "5 barbell push-press at 60-70% of 1RM", "Rest 1-2 minutes", "10 double kettlebell/dumbbell squat jumps", "Rest 1-2 minutes", "5 kettlebell/dumbbell snatches per arm", "Rest 1-2 minutes", "5 plyo pull-ups", "Rest 1-2 minutes", "x3 rounds", "Perform all exercises with maximum speed and explosiveness."
            ]),
            HICWorkoutInstruction(number: 39, title: "Kinetic Conditioning", instructions: [
                "50m sprint + 5 explosive plyometric push-ups", "Rest 2 minutes", "50m sprint + 5 explosive squat jumps", "Rest 2 minutes", "x3 rounds", "All movements must be performed at maximum intensity. Take more than 2 minutes of rest if needed."
            ]),
            HICWorkoutInstruction(number: 40, title: "Transition Complex", instructions: [
                "3 front squats at 85% of 1RM", "10 squat jumps", "Rest 2 minutes", "3 standing overhead presses at 85% of 1RM", "10 plyometric push-ups", "Rest 2 minutes", "3 weighted pull-ups", "10 medicine ball slams", "x2-3 rounds", "The heavy lifts should prime you for the power work."
            ])
        ]
    }
}
