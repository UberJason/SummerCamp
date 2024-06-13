import SwiftUI

struct ScheduleView: View {
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.kids.first!.scheduleItems, id: \.date) { item in
                    Section {
                        ForEach(item.activities, id: \.id) { activity in
                            ActivityCell(activity: activity)
                        }
                    } header: {
                        Text(item.date, format: .dateTime.weekday(.wide).day().month().year()).sectionHeaderStyle()
                    }
                }
            }
            .navigationTitle("Camp Schedule")
        }
    }
}

#Preview {
    ScheduleView()
}
