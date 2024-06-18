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
    var date: Date = Date.truncatedToday
    
    init() {
        let parser = ActivitiesParser()
        
        kids = [
            Kid(
                name: "Ming Ming",
                scheduleItems: parser.parseSummerCamp(from: summerCampActivities)
            ),
            Kid(
                name: "Mei Mei",
                scheduleItems: parser.parsePreschool(from: preschoolSchedule)
            )
        ]
    }
    
    func isClosed(on date: Date) -> Bool {
        Set(
            kids
                .flatMap(\.scheduleItems)
                .filter { $0.date == date }
                .flatMap(\.activities)
                .map(\.activityType)
        )
        .contains(.closed)
    }
    
    func packItems(for kid: Kid, on date: Date) -> [PackItem] {
        var items = kids
            .filter { $0.name == kid.name }
            .first?
            .scheduleItems
            .filter { $0.date == date }
            .flatMap(\.packItems)
        
        
        let weekday = Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        
        if weekday == "Monday" && kid.name == "Mei Mei" {
            items?.append(.campShirt)
        }
            
        return items?.sorted { $0.sortValue < $1.sortValue } ?? []
    }
    
    func activities(for kid: Kid, on date: Date) -> [Activity] {
        kids
            .filter { $0.name == kid.name }
            .first?
            .scheduleItems
            .filter { $0.date == date }
            .flatMap(\.activities)
        ?? []
    }
    
    var allDates: [Date] {
        kids.flatMap(\.scheduleItems).map(\.date).removingDuplicates().sorted(by: <)
    }
}

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        TabView {
            DayView()
                .environment(viewModel)
                .tabItem {
                    Label("Today", systemImage: "\(Date().formatted(.dateTime.day())).square")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    withAnimation {
                        viewModel.date = Date.truncatedToday
                    }
                }
            
            ScheduleView(kid: viewModel.kids.filter { $0.name == "Ming Ming" }.first!, title: "Ming Ming")
                .environment(viewModel)
                .tabItem {
                    Label("Camp Schedule", systemImage: "calendar")
                }
            
            ScheduleView(kid: viewModel.kids.filter { $0.name == "Mei Mei" }.first!, title: "Mei Mei")
                .environment(viewModel)
                .tabItem {
                    Label("Preschool Schedule", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}
