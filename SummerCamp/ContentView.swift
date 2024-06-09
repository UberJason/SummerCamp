//
//  ContentView.swift
//  SummerCamp
//
//  Created by Jason Ji on 6/8/24.
//

import SwiftUI

@Observable
class ViewModel {
    let items: [ScheduleItem]
    
    init() {
        items = ActivitiesParser().parse(from: activities)
    }
}

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        TabView {
            DayView()
                .tabItem {
                    Label("Today", systemImage: "\(Date().formatted(.dateTime.day())).square")
                }
            
            ScheduleView()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}
