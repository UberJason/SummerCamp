import SwiftUI

public extension View {
    func sectionHeaderStyle() -> some View {
        self
            .textCase(nil)
            .headerProminence(.increased)
            .padding([.leading, .trailing], -18)
    }
}
