//
//  DayFilterView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct DayFilterView: View {
    @Binding var isSelectedDay: Int
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(0..<7) { day in
                    FilterDayCardCell(month: "Nov", day: day.description, weekDay: "Sun", isSelected: day == isSelectedDay)
                        .onTapGesture { isSelectedDay = day }
                }
            }
            .padding(.leading)
        }
        .frame(height: 125)

    }
}

#Preview {
    DayFilterView(isSelectedDay: .constant(0))
}
