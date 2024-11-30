//
//  DayFilterView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct DayFilterView: View {
    var days: [Date]
    @Binding var isSelectedDay: Int
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(days, id: \.self) { date in
                    FilterDayCardCell(
                        date: date,
                        isSelected: DateFormatterHelp.shared.getDay(date: date) == isSelectedDay
                    )
                    .onTapGesture { isSelectedDay = DateFormatterHelp.shared.getDay(date: date) }
                }
            }
            .padding(.leading)
        }
        .frame(height: 125)
        .onChange(of: days) { _, newValue in
            if let firstDay = newValue.first {
                isSelectedDay = DateFormatterHelp.shared.getDay(date: firstDay)
            }
        }

    }
}

#Preview {
    DayFilterView(days: [], isSelectedDay: .constant(0))
}
