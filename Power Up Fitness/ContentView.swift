//
//  ContentView.swift
//  Power Up Fitness
//
//  Created by Lucas Hunter on 8/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                WorkoutListView()
            }
            .tabItem {
                Image(systemName: "dumbbell")
                Text("Workouts")
            }
            
            TrainingVaultListView()
            .tabItem {
                Image(systemName: "folder")
                Text("Training Vault")
            }
        }
    }
}

#Preview {
    ContentView()
}
