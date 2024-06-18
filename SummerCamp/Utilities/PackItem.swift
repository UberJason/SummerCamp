import SwiftUI

struct PackItem: Hashable, Identifiable {
    var id: String { name }
    
    let name: String
    let icon: Image
    let sortValue: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static let campShirt = PackItem(name: "Blue Camp Shirt", icon: .clothes, sortValue: 0)
    static let swimClothes = PackItem(name: "Swim clothes", icon: .pool, sortValue: 1)
    static let backpack = PackItem(name: "Backpack", icon:. backpack, sortValue: 2)
    static let waterBottle = PackItem(name: "Water bottle", icon: .waterBottle, sortValue: 3)
    static let spareClothes = PackItem(name: "Change of clothes", icon: .clothes, sortValue: 4)
    static let towel = PackItem(name: "Towel", icon: .towel, sortValue: 5)
    static let waterShoes = PackItem(name: "Water shoes", icon: .shoes, sortValue: 6)
    static let goggles = PackItem(name: "Goggles", icon: .goggles, sortValue: 7)
    static let bag = PackItem(name: "Bag", icon: .bag, sortValue: 8)
    static let `switch` = PackItem(name: "Nintendo Switch", icon: .game, sortValue: 9)
}

extension ActivityType {
    var packItems: [PackItem] {
        switch self {
        case .closed:
            return []
        case .pool:
            return [.swimClothes, .backpack, .waterBottle, .spareClothes, .towel, .waterShoes, .goggles]
        case .fullDayFieldTrip:
            return [.backpack, .waterBottle, .spareClothes, .switch]
        case .waterPlay:
            return [.towel, .spareClothes, .waterShoes, .swimClothes]
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
    }
}

extension Array where Self: Hashable {
    func removingDuplicates() -> Array {
        Array(Set(self))
    }
}
