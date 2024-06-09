import Foundation

class ActivitiesParser {
    func parse(from string: String) -> [ScheduleItem] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M-d-yy"
        
        let lines = string.components(separatedBy: "\n")
        
        var activityGroups: [[String]] = []
        var currentGroup = [String]()
        
        for line in lines {
            if line == "" {
                activityGroups.append(currentGroup)
                currentGroup = [String]()
            } else {
                currentGroup.append(line)
            }
        }
        activityGroups.append(currentGroup)
        
        print(activityGroups)
        
        let items = activityGroups.map { group in
            ScheduleItem(
                date: dateFormatter.date(from: group.first!)!,
                activities: group[1...].compactMap { Activity(textFileString: $0) }
            )
        }
        
        return items
    }
}

extension Activity {
    init?(textFileString string: String) {
        let lines = string.components(separatedBy: ";").map { $0.trimmingCharacters(in: .whitespaces) } // ["pool", "hunters woods"]
        guard lines.count == 2 else {
            return nil
        }
        guard let type = ActivityType(string: lines[0]) else {
            return nil
        }
        
        self.init(activityType: type, activityDescription: lines[1])
    }
}

extension ActivityType {
    init?(string: String) {
        if string == "pool"  { self = .pool }
        else if string == "steam" { self = .steam }
        else if string == "team" { self = .team }
        else if string == "partDayFieldTrip" { self = .partDayFieldTrip }
        else if string == "fullDayFieldTrip" { self = .fullDayFieldTrip }
        else if string == "closed" { self = .closed }
        else if string.starts(with: "other") {
            self = .other(title: String(string.components(separatedBy: "(").first!.dropLast()))
        } else {
            return nil
        }
    }
}

let activities = """
6/17/24
pool; Hunters Woods Pool
team; Ninja Beam Challenge

6/18/24
steam; Katakana Headbands
partDayFieldTrip; Briar Patch Park

6/19/24
closed; Juneteenth

6/20/24
pool; Shadowood Pool
other(Friday Film Event); Teenage Mutant Ninja Turtles: Mutant Mayhem (2023) (PG)

6/21/24
pool; Lake Thoreau Pool
partDayFieldTrip; Ninja Warrior & Rock Climbing @ Fitness Equation: One Loudon
"""
