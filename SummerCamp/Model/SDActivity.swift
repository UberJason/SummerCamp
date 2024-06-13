import Foundation
import SwiftData

@Model
class SDActivity {
    public var activityType: ActivityType = ActivityType.pool
    public var activityDescription: String? = ""
    public var scheduleItem: SDScheduleItem?
    
    init(activityType: ActivityType, activityDescription: String) {
        self.activityType = activityType
        self.activityDescription = activityDescription
    }
}

enum ActivityType: Hashable, Codable {
    case pool, steam, team, partDayFieldTrip, fullDayFieldTrip, film, other(title: String), closed
    case rccDay, walkingFieldTrip, wingDay, waterPlay
    
    var title: String {
        switch self {
        case .pool:
            "Swimming Field Trip"
        case .steam:
            "STEAM Activity"
        case .team:
            "Team Activity"
        case .partDayFieldTrip:
            "Field Trip"
        case .fullDayFieldTrip:
            "Full Day Field Trip"
        case .film:
            "Friday Film Event"
        case .other(let title):
            title
        case .closed:
            "RCC CLOSED"
            
        case .rccDay:
            "RCC Day"
        case .walkingFieldTrip:
            "Walking Field Trip"
        case .wingDay:
            "Wing Day"
        case .waterPlay:
            "Water Play"
        }
    }
}

struct Activity: Hashable, Identifiable, Codable {
    public var activityType: ActivityType
    public var activityDescription: String?
    
    var id: String {
        "\(activityType.title)\(String(describing: activityDescription))"
    }
}
