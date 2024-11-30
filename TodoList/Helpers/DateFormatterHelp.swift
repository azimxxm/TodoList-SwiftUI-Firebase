//
//  DateFormatterHelp.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 30/11/24.
//
import Foundation

class DateFormatterHelp {
    static let shared = DateFormatterHelp()
    private init() {}

    func dateFormatter(with format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }

    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long // Bu format uchun 'November 30, 2024'
        formatter.locale = Locale(identifier: "en_US") // Inglizcha format uchun
        return formatter.string(from: date)
    }

    func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }

    func today() -> String {
        formatDate(date: Date())
    }

    func getDay(date: Date) -> Int {
        Calendar.current.component(.day, from: date)
    }

    func getMonthName(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }

    func getWeekDayName(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter.string(from: date)
    }
}
