//
//  AddStrokeViewModifier.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//


import SwiftUI

struct AddStrokeViewModifier: ViewModifier {
    let color: Color
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .inset(by: 0.5)
                    .stroke(color, lineWidth: lineWidth)
            }
    }
}

extension View {
    func addStroke(color: Color = .main.opacity(0.4), lineWidth: CGFloat = 1.0, cornerRadius: CGFloat = 0) -> some View {
        self.modifier(AddStrokeViewModifier(color: color, lineWidth: lineWidth, cornerRadius: cornerRadius))
    }
}
