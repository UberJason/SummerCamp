import SwiftUI

struct DayView: View {
    @ScaledMetric var width = 20.0
    @ScaledMetric var spacing = 6.0
    
    @Environment(ViewModel.self) var viewModel
    let date: Date
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.kids, id: \.name) { kid in
                        VStack(alignment: .leading, spacing: 6.0) {
                            Text(kid.name)
                                .font(.headline)
                                .padding(.bottom, 8)
                            
                            VStack(alignment: .titleLeading, spacing: spacing) {
                                ForEach(viewModel.packItems(for: kid, on: date)) { item in
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
                        FakeListView(items: viewModel.kids) { kid in
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
            .navigationTitle("\(date.formatted(.dateTime.day().month(.wide).weekday(.wide)))")
        }
    }
}

#Preview {
    DayView(date: Date.truncatedToday)
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
