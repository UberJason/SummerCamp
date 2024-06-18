import SwiftUI

struct DateSelectionControl: View {
    @Binding var date: Date
    let allDates: [Date]
    
    var body: some View {
        HStack(spacing: 24.0) {
            Button {
                withAnimation {
                    date = previousValidDate(before: date)
                }
            } label: {
                Image.chevronLeft.opacity(previousButtonDisabled ? 0.3 : 1.0)
            }
            .disabled(previousButtonDisabled)
            Text("\(relativeDateTimeFormatter.localizedString(for: date, relativeTo: Date.truncatedToday).capitalized)")
                .frame(minWidth: 100)
            Button {
                withAnimation {
                    date = nextValidDate(after: date)
                }
            } label: {
                Image.chevronRight.opacity(nextButtonDisabled ? 0.3 : 1.0)
            }
            .disabled(nextButtonDisabled)
        }
        .foregroundStyle(.secondary)
        .font(.headline)
        .fontWeight(.bold)
        .padding()
        .background(.ultraThinMaterial, in: Capsule())
        .padding()
    }
    
    var previousButtonDisabled: Bool {
        date == allDates.first ?? .distantPast
    }
    
    var nextButtonDisabled: Bool {
        date == allDates.last ?? .distantFuture
    }
    
    /// Returns the next date in the range of `allDates`.
    /// *Assumption:* `date` within the range `[allDates.first ... allDates.last]`.
    func nextValidDate(after date: Date) -> Date {
        let validDates = Set(allDates)
        
        var nextDate = date.adding(1, .day)
        while !validDates.contains(nextDate) && !(nextDate < allDates.first!) && !(nextDate > allDates.last!) {
            nextDate = nextDate.adding(1, .day)
        }
        
        return nextDate
    }
    
    /// Returns the previous date in the range of `allDates`.
    /// *Assumption:* `date` within the range `[allDates.first ... allDates.last]`.
    func previousValidDate(before date: Date) -> Date {
        let validDates = Set(allDates)
        
        var nextDate = date.subtracting(1, .day)
        while !validDates.contains(nextDate) && !(nextDate < allDates.first!) && !(nextDate > allDates.last!) {
            nextDate = nextDate.subtracting(1, .day)
        }
        
        return nextDate
    }
}
