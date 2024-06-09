import Foundation
import SwiftData

@Model
class SDActivity {
    public var activityType: ActivityType = ActivityType.pool
    public var activityDescription: String = ""
    public var scheduleItem: SDScheduleItem?
    
    init(activityType: ActivityType, activityDescription: String) {
        self.activityType = activityType
        self.activityDescription = activityDescription
    }
}
