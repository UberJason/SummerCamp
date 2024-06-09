//
//  SummerCampApp.swift
//  SummerCamp
//
//  Created by Jason Ji on 6/8/24.
//

import SwiftUI

@main
struct SummerCampApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}

struct AppView: View {
    var body: some View {
        ContentView()
            .environment(CampStore.shared)
            .modelContext(CampStore.shared.mainContext)
    }
}
