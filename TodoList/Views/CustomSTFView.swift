//
//  CustomSTFView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//


import SwiftUI

struct CustomSTFView: View {
    @Binding var text: String
    var placeholder: String = "Placeholder"
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        SecureField("", text: $text, prompt: Text(placeholder).foregroundStyle(.textGray))
            .padding()
            .keyboardType(keyboardType)
            .foregroundStyle(.text)
            .background(.white)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.bg.ignoresSafeArea()
        CustomSTFView(text: .constant(""))
    }
}
