import SwiftUI

struct DayView: View {
    @ScaledMetric var width = 20.0
    @ScaledMetric var spacing = 6.0
    
    let kids = [
        Kid(
            name: "Ming Ming",
            scheduleItems: [
                ScheduleItem(
                    date: Date(),
                    activities: [
                        Activity(activityType: .pool, activityDescription: "Hunters Woods Pool"),
                        Activity(activityType: .fullDayFieldTrip, activityDescription: "Ninja Beam Challenge"),
                    ]
                )
            ]
        ),
        Kid(
            name: "Mei Mei",
            scheduleItems: [
                ScheduleItem(
                    date: Date(),
                    activities: [
                        Activity(activityType: .other(title: "RCC Day"))
                    ]
                )
            ]
        )
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(kids, id: \.name) { kid in
                        VStack(alignment: .leading, spacing: 6.0) {
                            Text(kid.name)
                                .font(.headline)
                                .padding(.bottom, 8)
                            
                            VStack(alignment: .titleLeading, spacing: spacing) {
                                ForEach(kid.scheduleItems.first!.packItems) { item in
                                    PackItemCell(item: item)
                                }
                            }
                        }
                    }
                } header: {
                    Text("Pack List")
                        .sectionHeaderStyle()
                }
                
                Section {
                    VStack(alignment: .leading) {
                        FakeListView(items: kids) { kid in
                            Text(kid.name).font(.headline)
                            Divider().offset(y: -2)
                            ForEach(kid.scheduleItems.first!.activities) { activity in
                                ActivityCell(activity: activity)
                            }
                        } divider: {
                            Spacer().frame(height: 24.0)
                        }
                    }
                    .padding([.top, .bottom], 4.0)
                } header: {
                    Text("Schedule")
                        .sectionHeaderStyle()
                }
            }
            .navigationTitle("\(Date().formatted(.dateTime.day().month(.wide).weekday(.wide)))")
        }
    }
}

#Preview {
    DayView()
}

struct PackItemCell: View {
    let item: PackItem
    @ScaledMetric var width = 20.0
    
    var body: some View {
        Label(
            title: {
                Text(item.name)
            },
            icon: {
                item.icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: width)
            }
        )
        .labelStyle(.icon)
    }
}
