import SwiftUI

struct DayView: View {
    
    @ScaledMetric var width = 20.0
    @ScaledMetric var spacing = 6.0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 4.0) {
                        Text("Ming Ming")
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        VStack(alignment: .titleLeading, spacing: spacing) {
                            Label(
                                title: { Text("Swim clothes") },
                                icon: { Image.pool.resizable().scaledToFit().frame(width: width, height: width) }
                            ).labelStyle(.icon)
                            Label(
                                title: { Text("Towel") },
                                icon: { Image(systemName: "water.waves").resizable().scaledToFit().frame(width: width, height: width) }
                            ).labelStyle(.icon)
                            Label(
                                title: { Text("Water Shoes") },
                                icon: { Image(systemName: "shoe.2").resizable().scaledToFit().frame(width: width, height: width) }
                            ).labelStyle(.icon)
                            Label(
                                title: { Text("Goggles") },
                                icon: { Image(systemName: "eyeglasses").resizable().scaledToFit().frame(width: width, height: width) }
                            ).labelStyle(.icon)
                            Label(
                                title: { Text("Backpack") },
                                icon: { Image(systemName: "backpack").resizable().scaledToFit().frame(width: width, height: width) }
                            ).labelStyle(.icon)
                            Label(
                                title: { Text("Plastic bag") },
                                icon: { Image(systemName: "bag").resizable().scaledToFit().frame(width: width, height: width) }
                            ).labelStyle(.icon)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Mei Mei")
                            .font(.headline)
                            .padding(.bottom, 8)
                        Text("Swim clothes")
                        Text("Towel")
                        Text("Backpack")
                    }
                } header: {
                    Text("Pack List")
                        .sectionHeaderStyle()
                }
                
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Ming Ming").font(.headline)
                        Divider().offset(y: -2)
                        ActivityCell(activity: Activity(activityType: .pool, activityDescription: "Hunters Woods Pool"))
                        ActivityCell(activity: Activity(activityType: .team, activityDescription: "Ninja Beam Challenge"))
                        Spacer().frame(height: 24)
                        Text("Mei Mei").font(.headline)
                        Divider().offset(y: -2)
                        ActivityCell(activity: Activity(activityType: .other(title: "RCC Day")))
                    }
                    .padding([.top, .bottom], 4.0)
                } header: {
                    Text("Schedule")
                        .sectionHeaderStyle()
                }
            }
            .navigationTitle("Monday, June 17")
        }
    }
}

#Preview {
    DayView()
}

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

public extension HorizontalAlignment {
    struct TitleLeading: AlignmentID {
        public static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.leading]
        }
    }
    
    static let titleLeading = HorizontalAlignment(TitleLeading.self)
}
