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
    static let watershoes = PackItem(name: "Water shoes", icon: .shoes)
    static let goggles = PackItem(name: "Goggles", icon: .goggles)
    static let backpack = PackItem(name: "Backpack", icon:. backpack)
    static let bag = PackItem(name: "Bag", icon: .bag)
}
