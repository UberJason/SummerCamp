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

struct Activity: Codable {
    public var activityType: ActivityType
    public var activityDescription: String?
    
    var id: String {
        "\(activityType.title)\(String(describing: activityDescription))"
    }
}
