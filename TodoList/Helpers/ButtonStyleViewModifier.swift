//
//  ButtonStyleViewModifier.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//
import SwiftUI

struct ButtonStyleViewModifier: ButtonStyle {
    
    let scale: CGFloat
    let opacity: Double
    let brightness: Double
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? opacity : 1)
            .brightness(configuration.isPressed ? brightness : 0)
    }
    
    
}

public enum ButtonType {
    case press, opacity, tap
}
