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

struct ScheduleItem: Hashable, Codable {
    public var date: Date
    public var activities: [Activity]
}
