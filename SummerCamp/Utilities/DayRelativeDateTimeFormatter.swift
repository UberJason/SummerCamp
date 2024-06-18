import Foundation

class DayRelativeDateTimeFormatter: RelativeDateTimeFormatter {
    override func localizedString(for date: Date, relativeTo referenceDate: Date) -> String {
        var string = super.localizedString(for: date, relativeTo: referenceDate)
        if string.lowercased() == "now" {
            string = "today"
        }
        
        return string
    }
}
