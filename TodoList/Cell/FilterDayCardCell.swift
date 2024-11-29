//
//  FilterDayCardCell.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct FilterDayCardCell: View {
    var month: String
    var day: String
    var weekDay: String
    var isSelected: Bool = false
    var body: some View {
        VStack(spacing: 6) {
            Text(month)
                .font(.callout)
                .foregroundStyle(.textGray)
            Text(day.description)
                .font(.title2)
                .bold()
                .foregroundStyle(.text.opacity(0.70))
            Text(weekDay)
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
    FilterDayCardCell(
        month: "Nov",
        day: "19",
        weekDay: "Sun"
    )
}
