import SwiftUI

struct DayView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Swim clothes")
                } header: {
                    Text("Pack List")
                        .sectionHeaderStyle()
                }
                
                
                Section {
                    Text("Swimming Field Trip")
                    Text("Ninja Beam Challenge")
                } header: {
                    Text("Activities")
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
