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
        ScrollViewReader(content: { scroll in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(days, id: \.self) { date in
                        FilterDayCardCell(
                            date: date,
                            isSelected: DateFormatterHelp.shared.getDay(date: date) == isSelectedDay
                        )
                        .id(date.description)
                        .onTapGesture { isSelectedDay = DateFormatterHelp.shared.getDay(date: date) }
                    }
                }
                .padding(.horizontal)
                .safeAreaPadding(.trailing)
            }
            .onChange(of: days) { _, newValue in
                if let lastDay = newValue.last {
                    isSelectedDay = DateFormatterHelp.shared.getDay(date: lastDay)
                    scroll.scrollTo(lastDay.description, anchor: .center)
                }
            }
        })
        .frame(height: 125)

    }
}

#Preview {
    DayFilterView(days: [], isSelectedDay: .constant(0))
}
