//
//  OnFirstAppearViewModifier.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//


import Foundation
import SwiftUI

struct OnFirstAppearViewModifier: ViewModifier {
    
    @State private var didAppear: Bool = false
    let action: @MainActor () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didAppear else { return }
                didAppear = true
                action()
            }
    }
}

extension View {
    
    public func onFirstAppear(perform action: @MainActor @escaping () -> Void) -> some View {
        modifier(OnFirstAppearViewModifier(action: action))
    }
}