import SwiftUI

let relativeDateTimeFormatter: RelativeDateTimeFormatter = {
    let f = DayRelativeDateTimeFormatter()
    f.dateTimeStyle = .named
    return f
}()

struct DayView: View {
    @ScaledMetric var width = 20.0
    @ScaledMetric var spacing = 6.0
    
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack {
            List {
                if !viewModel.isClosed(on: viewModel.date) {
                    Section {
                        ForEach(viewModel.kids, id: \.name) { kid in
                            VStack(alignment: .leading, spacing: 6.0) {
                                Text(kid.name)
                                    .font(.headline)
                                    .padding(.bottom, 8)
                                    .animation(nil, value: viewModel.date)
                                
                                VStack(alignment: .titleLeading, spacing: spacing) {
                                    ForEach(viewModel.packItems(for: kid, on: viewModel.date)) { item in
                                        PackItemCell(item: item)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Pack List")
                            .sectionHeaderStyle()
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        FakeListView(items: viewModel.kids) { kid in
                            Text(kid.name).font(.headline)
                            Divider().offset(y: -2)
                            ForEach(viewModel.activities(for: kid, on: viewModel.date)) { activity in
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
            .safeAreaPadding(.bottom, 50)
            .navigationTitle("\(viewModel.date.formatted(.dateTime.day().month(.wide).weekday(.wide)))")
            .overlay(alignment: .bottom) {
                DateSelectionControl(date: $viewModel.date, allDates: viewModel.allDates)
            }
        }
    }
}

#Preview {
    DayView()
        .environment(ViewModel())
}
