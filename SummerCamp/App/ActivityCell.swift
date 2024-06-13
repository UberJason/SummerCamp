import SwiftUI

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
        case .rccDay:
            return .orange
        case .walkingFieldTrip:
            return .cyan
        case .wingDay:
            return .indigo
        case .waterPlay:
            return .blue
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
        case .rccDay:
            return .rcc
        case .walkingFieldTrip:
            return .walk
        case .wingDay:
            return .turtle
        case .waterPlay:
            return .waterPlay
        }
    }
}
