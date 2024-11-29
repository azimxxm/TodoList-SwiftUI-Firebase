//
//  CustomTFView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct CustomTFView: View {
    @Binding var text: String
    var placeholder: String = "Placeholder"
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(.textGray))
            .padding()
            .keyboardType(keyboardType)
            .background(.white)
            .foregroundStyle(.text)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.bg.ignoresSafeArea()
        CustomTFView(text: .constant(""))
    }
}
