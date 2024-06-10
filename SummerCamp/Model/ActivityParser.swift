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
        
        guard let type = ActivityType(string: lines[0]) else {
            return nil
        }
        
        let activityDescription: String? = if lines.count == 2 { lines[1] } else { nil }
        self.init(activityType: type, activityDescription: activityDescription)
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
        else if string == "film" { self = .film }
        else if string.starts(with: "other") {
            self = .other(title: String(string.components(separatedBy: "(")[1].dropLast()))
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
film; Teenage Mutant Ninja Turtles: Mutant Mayhem (2023) (PG)

6/21/24
pool; Lake Thoreau Pool
partDayFieldTrip; Ninja Warrior & Rock Climbing @ Fitness Equation: One Loudon

6/24/24
pool; Hunters Woods Pool
partDayFieldTrip; Ashburn Dinosaur Park

6/25/24
steam; LEGO Bridge Weight Challenge
partDayFieldTrip; Arrowbrook Park

6/26/24
fullDayFieldTrip; LEGO Discovery Center

6/27/24
pool; Shadowood Pool
steam; LEGO Zipline Challenge

6/28/24
pool; Lake Thoreau Pool
film; The Lego Movie 2 (2019) (PG)

7/1/24
pool; Hunters Woods Pool
team; Fort Battle - Capture the Flag

7/2/24
steam; Homemade Catapults
partDayFieldTrip; Baron Cameron Park

7/3/24
other(Fort Camping); Electronics & Disney Movie Marathon
other(Independence Day Cookout Celebration)

7/4/24
closed; 4th of July

7/5/24
closed; 4th of July

7/8/24
pool; Hunters Woods Pool
team; Group and Act setup

7/9/24
partDayFieldTrip; Ashburn Trailside Park
team; Practice & Prop Making

7/10/24
team; Practice & Prop Making
partDayFieldTrip; Fairfax Fun Land

7/11/24
pool; Shadowood Pool
partDayFieldTrip; Slurpee Day @ 7-11 & Haley Smith Park

7/12/24
pool; Lake Thoreau Pool
other(Red Carpet and Hollywood Live)

7/15/24
pool; Hunters Woods Pool
team; Pirate Ship Building

7/16/24
other(Firetruck Splash Day); RCC Parking Lot
team; Pirate Ship Building

7/17/24
fullDayFieldTrip; Hanson Regional Park Ultrazone Loudon

7/18/24
pool; Shadowood Pool
team; Pirate Ship Battle

7/19/24
pool; Lake Thoreau Pool
film; The Sea Beast (2022) (PG)

7/22/24
pool; Hunters Woods Pool
team; Mini River Settlement

7/23/24
partDayFieldTrip; Great Falls Park: Hiking & Sports
steam; Mud Painting

7/24/24
fullDayFieldTrip; Catoctin Wildlife Preserve

7/25/24
fullDayFieldTrip; Washington Nationals

7/26/24
pool; Lake Thoreau Pool
film; Over the Hedge (2006) (PG)

7/29/24
pool; Hunters Woods Pool
partDayFieldTrip; Clemyjontri Park

7/30/24
other(Theatre-in-the-Woods); Carpathia Folk Dance Ensemble, "Dancing Kaleidescope"
steam; Country Flag Rocks

7/31/24
fullDayFieldTrip; Olympic Games @ FCPS School

8/1/24
pool; Shadowood Pool
other(RCC Dance Party); RCC

8/2/24
pool; Lake Thoreau Pool
film; Miracle (2004) (PG)
"""
