import SwiftUI

public extension HorizontalAlignment {
    struct TitleLeading: AlignmentID {
        public static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.leading]
        }
    }
    
    static let titleLeading = HorizontalAlignment(TitleLeading.self)
}

