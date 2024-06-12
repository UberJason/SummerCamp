import SwiftUI

struct IconLabelStyle: LabelStyle {
    @ScaledMetric var spacing = 12.0
    @ScaledMetric var firstTextbaselineVerticalOffset = 4.0
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: spacing) {
            configuration.icon
                .alignmentGuide(.firstTextBaseline) { d in d[.firstTextBaseline] - firstTextbaselineVerticalOffset }
            configuration.title
                .alignmentGuide(.titleLeading) { d in d[.leading] }
        }
    }
}

extension LabelStyle where Self == IconLabelStyle {
    static var icon: IconLabelStyle { IconLabelStyle() }
}
