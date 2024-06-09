import SwiftUI

struct ScheduleView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items, id: \.date) { item in
                    Section {
                        ForEach(item.activities, id: \.id) { activity in
                            VStack(alignment: .leading) {
                                Text(activity.activityType.title).font(.headline)
                                activity.activityDescription.map {
                                    Text($0).font(.subheadline)
                                }
                            }
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
