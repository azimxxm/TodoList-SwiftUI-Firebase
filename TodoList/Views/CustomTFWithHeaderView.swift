//
//  CustomTFWithHeaderView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct CustomTFWithHeaderView: View {
    var title: String = "Enter name"
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.text)
                .padding(.leading)
            CustomTFView(text: $text, keyboardType: keyboardType)
        }
    }
}

#Preview {
    ZStack {
        Color.bg.ignoresSafeArea()
        CustomTFWithHeaderView(text: .constant(""))
    }
}
