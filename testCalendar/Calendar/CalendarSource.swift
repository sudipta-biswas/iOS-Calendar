//
//  CalendarSource.swift
//  testCalendar
//
//  Created by Sudipta Biswas on 08/07/20.
//  Copyright © 2020 Sudipta Biswas. All rights reserved.
//

import UIKit

class CalendarSource {

    static let shared = CalendarSource()
    
    let calendar = Calendar.current
    let todaysDate = Date()
    var currentSelectedDate = Date()
    var monthData = [calendarUnit]()
    private let dateFormatter = DateFormatter()
    var selectedCalendarUnit:calendarUnit?
    
    
    // MARK:- Get Today
    /// - Returns: Day 
    func getTodayDate()->Int {
        let date = Date()
        let dateComponents = calendar.dateComponents([.day], from: date)
        return dateComponents.day!
    }
    
    // MARK:- Get Current Year
    /// - Parameter _date: Date
    /// - Returns: Year
    func getCurrentYear(_date:Date)->Int {
        let dateComponents = calendar.dateComponents([.year], from: _date)
        return dateComponents.year!
    }
    
    // MARK:- Get Current Day Name
    /// - Returns: Day name
    func getCurrentDayName()->String {
        dateFormatter.dateFormat  = "EE"
        let dayName = dateFormatter.string(from: Date())
        return dayName
    }
    
    // MARK:- Get current Month Number and Name
    /// - Parameter _date: Date
    /// - Returns: Current Month Number and Name
    func getCurrentMonth(_date:Date)->(Int,String) {
        let month =  calendar.date(byAdding: .month, value: 0, to: _date)
        let monthNumber =  calendar.dateComponents([.month], from: month!).month!
        let monthName = DateFormatter().monthSymbols[monthNumber - 1]
        return (monthNumber,monthName)
    }
    
    // MARK:- Get Current Month Data
    /// - Returns: Prepare All Calendar UNIT data in array
    func prepareCurrentMonth()->[calendarUnit] {
        let monthDate =  calendar.date(byAdding: .month, value: 0, to: currentSelectedDate)
        self.currentSelectedDate = monthDate!
        return self.prepareCalendarDatesForCurrentMonth()
    }
    
    // MARK:- Prepare Next Month Data
    /// - Returns: All Calendar UNIT Objects in Array
    func prepareNextMonth()->[calendarUnit] {
        let monthDate =  calendar.date(byAdding: .month, value: 1, to: currentSelectedDate)
        self.currentSelectedDate = monthDate!
        return self.prepareCalendarDatesForCurrentMonth()
    }
    
    // MARK:- Prepare Previous Month Data
    /// - Returns: All Calendar UNIT Objects in array
    func preparePreviousMonth()->[calendarUnit] {
        let monthDate =  calendar.date(byAdding: .month, value: -1, to: currentSelectedDate)
        self.currentSelectedDate = monthDate!
        return self.prepareCalendarDatesForCurrentMonth()
    }
    
    // MARK:- Get No if days of a current date Month
    /// - Parameter _date: Date
    /// - Returns: Total no of days of current month
    func getNoOfDays(_date:Date)->Int {
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: _date)!
        return range.upperBound - range.lowerBound
    }
    
    // MARK:- Prepare Date and Day name of a date
    /// - Parameters:
    ///   - day: String
    ///   - month: String
    ///   - year: String
    /// - Returns: Date and Curent date day name
    private func prepareDateAndDay(day:String,month:String,year:String)->(Date,String) {
        
        dateFormatter.dateFormat  = "EE"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateComponents = DateComponents(calendar: calendar,
                                            year: Int(year),
                                            month: Int(month),
                                            day: Int(day))

        let _validDate = calendar.date(from: dateComponents)!
         let dayName = dateFormatter.string(from: _validDate)
        return (_validDate,dayName)
    }

    
    // MARK:- Prepare Calendar for dates for current Month
    /// - Returns: Calendar UNIT list with all details
   private func prepareCalendarDatesForCurrentMonth()->[calendarUnit] {
        
        let currentDate = self.currentSelectedDate
        let noOfDaysOfThatMonth = self.getNoOfDays(_date: currentDate)
        let currentMonth = self.getCurrentMonth(_date: currentDate)
        let currentYear = self.getCurrentYear(_date: currentDate)
        
        self.monthData.removeAll()
        for i in 1..<noOfDaysOfThatMonth+1 {
            let objDateDay = self.prepareDateAndDay(day: "\(i)", month: "\(currentMonth.0)", year: "\(currentYear)")
            let objCaldarData = calendarUnit()
            objCaldarData.day = "\(i)"
            objCaldarData.dayName = objDateDay.1
            objCaldarData.month = "\(currentMonth.1)"
            objCaldarData.year = "\(currentYear)"
            objCaldarData.date = objDateDay.0
            objCaldarData.dateString = "\(objDateDay.0)"
            if self.getTodayDate() == i && self.getCurrentYear(_date: Date()) == currentYear && self.getCurrentMonth(_date: Date()).1 == "\(currentMonth.1)" {
                objCaldarData.isToday = true
                self.selectedCalendarUnit = objCaldarData
            } else {
                 objCaldarData.isToday = false
            }
            
            self.monthData.append(objCaldarData)
        }
        return self.monthData
    }
    
}

class calendarUnit {
    var month = ""
    var day = ""
    var dayName = ""
    var year = ""
    var date = Date()
    var dateString = ""
    var isToday = false
    var isAppointmentAvailable = false
}
