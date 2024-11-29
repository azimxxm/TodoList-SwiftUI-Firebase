//
//  ButtonView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct ButtonView: View {
    var title: String = "Get Started"
    var foregroundStyle: Color = .text
    var backgroundColor: Color = .main
    var fonWidth: Font.Weight? = .medium
    var action: (() -> Void)?
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .font(.title2)
                .foregroundStyle(foregroundStyle)
                .padding()
                .fontWeight(fonWidth)
                .background(backgroundColor)
                .cornerRadius(10)
        }
        .buttonStyle(.plain)

    }
}

#Preview {
    ButtonView()
}
