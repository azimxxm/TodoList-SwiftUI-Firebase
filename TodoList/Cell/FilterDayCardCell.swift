//
//  FilterDayCardCell.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct FilterDayCardCell: View {
    var date: Date
    var isSelected: Bool = false
    var body: some View {
        VStack(spacing: 6) {
            Text(DateFormatterHelp.shared.getMonthName(date: date))
                .font(.callout)
                .foregroundStyle(.textGray)
            Text(DateFormatterHelp.shared.getDay(date: date).description)
                .font(.title2)
                .bold()
                .foregroundStyle(.text.opacity(0.70))
            Text(DateFormatterHelp.shared.getWeekDayName(date: date))
                .font(.callout)
                .foregroundStyle(.textGray)
        }
        .frame(width: 60, height: 76)
        .padding(10)
        .background(isSelected ? .main.opacity(0.25) : .black.opacity(0.0001))
        .cornerRadius(12)
    }
}

#Preview {
    FilterDayCardCell(date: Date())
}
