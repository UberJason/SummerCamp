import SwiftUI

struct DateSelectionControl: View {
    @Binding var date: Date
    
    var body: some View {
        HStack(spacing: 24.0) {
            Button {
                withAnimation {
                    date = date.subtracting(1, .day)
                }
            } label: {
                Image.chevronLeft
            }
            Text("\(relativeDateTimeFormatter.localizedString(for: date, relativeTo: Date.truncatedToday).capitalized)")
                .frame(minWidth: 100)
            Button {
                withAnimation {
                    date = date.adding(1, .day)
                }
            } label: {
                Image.chevronRight
            }
        }
        .foregroundStyle(.secondary)
        .font(.headline)
        .fontWeight(.bold)
        .padding()
        .background(.ultraThinMaterial, in: Capsule())
        .padding()
    }
}
