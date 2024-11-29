//
//  CustomSTFWithHeaderView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct CustomSTFWithHeaderView: View {
    var title: String = "Custom STF"
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.text)
                .padding(.leading)
            CustomSTFView(text: $text, keyboardType: keyboardType)
        }
    }
}

#Preview {
    ZStack {
        Color.bg.ignoresSafeArea()
        CustomSTFWithHeaderView(text: .constant(""))
    }
}
