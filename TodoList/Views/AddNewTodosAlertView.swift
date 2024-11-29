//
//  AddNewTodosAlertView.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 30/11/24.
//

import SwiftUI

struct AddNewTodosAlertView: View {
    @State private var title = ""
    @State private var detail = ""
    var saveAction: ((ItemDM)-> Void)?

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter title.", text: $title)
            TextField("Enter detail.", text: $detail)
            
            HStack(spacing: 16) {
                Button("Cancel", role: .cancel) { clearFields() }
                Button("Save") { checkAndSend() }
            }
        }
        .padding()
    }
    
    private func checkAndSend() {
        guard !title.isEmpty, !detail.isEmpty else { return }
        saveAction?( ItemDM(title: title, details: detail, createdAt: .now))
        clearFields()
    }
    
    private func clearFields() {
        title = ""
        detail = ""
    }
}

#Preview {
    AddNewTodosAlertView()
}
