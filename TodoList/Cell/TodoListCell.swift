//
//  TodoListCell.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct TodoListCell: View {
    @ObservedObject var item: ItemDM
    var selected: (()-> Void)?
    var body: some View {
        HStack {
            Rectangle()
                .fill(item.isCompleted ? .main.opacity(0.76) : .main.opacity(0.001))
                .frame(width: 20, height: 20)
                .clipShape(Circle())
                .addStroke(cornerRadius: 10)
                .onTapGesture { selected?() }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                    .lineLimit(2)
                    .font(.title3)
                    .foregroundStyle(.text.opacity(0.76))
                Text(item.createdAt, format: .dateTime)
                    .font(.caption)
                    .foregroundStyle(.textGray)
            }
                
        }
        .strikethrough(item.isCompleted)
    }
}

#Preview {
    TodoListCell(item: ItemDM(title: "Salom"))
}
