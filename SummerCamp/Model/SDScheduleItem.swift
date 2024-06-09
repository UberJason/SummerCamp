import Foundation
import SwiftData

enum ActivityType: Hashable, Codable {
    case pool, steam, team, partDayFieldTrip, fullDayFieldTrip, film, other(title: String), closed
    
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
        }
    }
}

@Model
class SDScheduleItem {
    public var date: Date = Date()
    
    @Relationship(deleteRule: .cascade, inverse: \SDActivity.scheduleItem)
    public var _activities: [SDActivity]?
    
    public var activities: [SDActivity] {
        get {
            _activities ?? []
        } set {
            _activities = newValue
        }
    }
    
    
    init(date: Date, activities: [SDActivity]) {
        self.date = date
        self.activities = activities
    }
}

struct ScheduleItem: Codable {
    public var date: Date
    public var activities: [Activity]
}

let json = """
[
    {
        "date" : "2024-06-17",
        "activities" : [
            {
                "activityType" : {
                    "pool" : {}
                },
                "activityDescription" : ""Hunters Woods Pool"
            }
        ]
    }

]
"""
