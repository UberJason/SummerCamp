import SwiftUI

struct ScheduleView: View {
    @Environment(ViewModel.self) var viewModel
    let kid: Kid
    let title: String
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(kid.scheduleItems, id: \.date) { item in
                    Section {
                        ForEach(item.activities, id: \.id) { activity in
                            ActivityCell(activity: activity)
                        }
                    } header: {
                        Text(item.date, format: .dateTime.weekday(.wide).day().month().year()).sectionHeaderStyle()
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}
