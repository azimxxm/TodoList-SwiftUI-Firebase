//
//  ErrorStateView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 30/11/24.
//

import SwiftUI

struct ErrorStateView: View {
    var errorMessage: String?
    var body: some View {
        if let errorMessage = errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ErrorStateView(errorMessage: "Somthing went wrong please try again!")
}
