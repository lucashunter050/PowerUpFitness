//
//  WorkoutRowView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/17/25.
//

import SwiftUI

struct WorkoutRowView: View {
    var body: some View {
        HStack {
            Text("🏋️‍♀️")
                .font(.system(size: 26))
            Spacer()
            Text("Strength Workout 8/17/25")
                .font(.system(size: 22))
            Spacer()
            Text("18:30")
        }
    }
}

#Preview {
    WorkoutRowView()
}
