import SwiftUI

struct ScheduleView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items, id: \.date) { item in
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

struct ActivityCell: View {
    let activity: Activity
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            activity.activityType.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(6)
                .foregroundStyle(.white)
                .frame(width: 32, height: 32)
                .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(activity.activityType.imageColor)
                    )
            
            VStack(alignment: .leading) {
                Text(activity.activityType.title).font(.headline)
                activity.activityDescription.map { Text($0).font(.subheadline) }
            }
        }
    }
}

#Preview {
    ScheduleView()
}

extension ActivityType {
    var imageColor: Color {
        switch self {
        case .pool:
            return .blue
        case .steam:
            return .purple
        case .team:
            return .gray
        case .partDayFieldTrip, .fullDayFieldTrip:
            return .yellow
        case .film:
            return .red
        case .other:
            return .green
        case .closed:
            return .red
        }
    }
    
    var image: Image {
        switch self {
        case .pool:
            return .pool
        case .steam:
            return .steam
        case .team:
            return .team
        case .partDayFieldTrip, .fullDayFieldTrip:
            return .bus
        case .film:
            return .film
        case .other:
            return .otherActivity
        case .closed:
            return .closed
        }
    }
}
