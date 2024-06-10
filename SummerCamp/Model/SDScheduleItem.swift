import Foundation
import SwiftData

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
