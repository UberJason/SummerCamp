//
//  ContentView.swift
//  SummerCamp
//
//  Created by Jason Ji on 6/8/24.
//

import SwiftUI

@Observable
class ViewModel {
    let kids: [Kid]
    
    init() {
        kids = [
            Kid(
                name: "Ming Ming",
                scheduleItems: ActivitiesParser().parse(from: activities)
            )
        ]
    }
    
    func packItems(for kid: Kid, on date: Date) -> [PackItem] {
        kids
            .filter { $0.name == kid.name }
            .first?
            .scheduleItems
            .filter { $0.date == date }
            .flatMap(\.packItems)
        ?? []
    }
}

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        TabView {
            DayView(date: Date(year: 2024, month: 6, day: 18))
                .environment(viewModel)
                .tabItem {
                    Label("Today", systemImage: "\(Date().formatted(.dateTime.day())).square")
                }
            
            ScheduleView()
                .environment(viewModel)
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}
