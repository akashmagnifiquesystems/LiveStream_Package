//
//  File.swift
//  
//
//  Created by Aakash Patel on 10/11/21.
//

import Foundation
import UIKit
struct Converter {
    
    static let shared = Converter()
    
    func convertTime(timeStamp : Int) -> String
    {
        if timeStamp > 0
        {
            let currentDate = Date()
            let streamDate = NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let dateString = dateFormatter.string(from: streamDate as Date)
            let newDate = dateFormatter.date(from: dateString)!
            let dateString2 = dateFormatter.string(from: currentDate)
            let newDate2 = dateFormatter.date(from: dateString2)!
            
            
            let strTimer : String = newDate.offset(from: newDate2)
            if !strTimer.isEmpty {
                if strTimer.contains("y") || strTimer.contains("w")
                {
                    return "More than 1 year"
                }
                let stDay: String = "\((Int(strTimer)! % 31536000) / 86400)"
                let stHour: String = "\((Int(strTimer)! % 86400) / 3600)"
                let stMin: String = "\((Int(strTimer)! % 3600) / 60)"
                if Int(stDay)! == 0
                {
                    return "\(stHour)h \(stMin)m"
                }else if Int(stHour)! == 0
                {
                    return "\(stMin)m"
                }else{
                    return "\(stDay)d \(stHour)h \(stMin)m"
                }
            }
            return "About 1 year"
        }else{
            return ""
        }
    }
}
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        var result: String = ""
        if days(from: date)    > 0 { result = result + " " + "\(days(from: date)) D" }
        if hours(from: date)   > 0 { result = result + " " + "\(hours(from: date)) H" }
        if minutes(from: date) > 0 { result = result + " " + "\(minutes(from: date)) M" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))" }
        return ""
    }
}
