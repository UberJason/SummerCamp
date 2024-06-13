import Foundation

public extension Date {
    init(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, using calendar: Calendar = Calendar.current) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        guard let date = calendar.date(from: dateComponents) else {
            self = Date()
            return
        }
        self = date
    }
    
    static var truncatedToday: Date {
        Date(year: Date().year, month: Date().month, day: Date().day)
    }
    
    static var truncatedTomorrow: Date {
        truncatedToday.adding(1, .day)
    }
    
    var truncated: Date {
        Date(year: year, month: month, day: day)
    }
    
    var isToday: Bool {
        return self.truncated == Date.truncatedToday
    }
    
    func adding(_ value: Int, _ component: Calendar.Component, using calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }
    
    func subtracting(_ value: Int, _ component: Calendar.Component, using calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: component, value: -1*value, to: self)!
    }
    
    var year: Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year!
    }
    
    var month: Int {
        let components = Calendar.current.dateComponents([.month], from: self)
        return components.month!
    }
    
    var day: Int {
        let components = Calendar.current.dateComponents([.day], from: self)
        return components.day!
    }
    
    static func daysBetween(start: Date, end: Date, using calendar: Calendar = .current) -> Int {
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day!
    }
}

extension Date: Identifiable {
    public var id: Date { self }
}
