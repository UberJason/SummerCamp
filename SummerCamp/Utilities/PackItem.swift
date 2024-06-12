import SwiftUI

struct PackItem: Hashable, Identifiable {
    var id: String { name }
    
    let name: String
    let icon: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static let swimClothes = PackItem(name: "Swim clothes", icon: .pool)
    static let towel = PackItem(name: "Towel", icon: .towel)
    static let waterShoes = PackItem(name: "Water shoes", icon: .shoes)
    static let goggles = PackItem(name: "Goggles", icon: .goggles)
    static let backpack = PackItem(name: "Backpack", icon:. backpack)
    static let bag = PackItem(name: "Bag", icon: .bag)
    static let waterBottle = PackItem(name: "Water bottle", icon: .waterBottle)
    static let spareClothes = PackItem(name: "Change of clothes", icon: .clothes)
    static let `switch` = PackItem(name: "Nintendo Switch", icon: .game)
}

extension ActivityType {
    var packItems: [PackItem] {
        switch self {
        case .pool:
            return [.towel, .backpack, .waterShoes, .goggles, .waterBottle, .spareClothes]
        case .fullDayFieldTrip:
            return [.backpack, .waterBottle, .spareClothes, .switch]
        default:
            return [.backpack, .waterBottle, .spareClothes]
        }
    }
}

extension ScheduleItem {
    var packItems: [PackItem] {
        activities
            .map(\.activityType)
            .flatMap(\.packItems)
            .removingDuplicates()
            .sorted { $0.name < $1.name }
    }
}

extension Array where Self: Hashable {
    func removingDuplicates() -> Array {
        Array(Set(self))
    }
}
