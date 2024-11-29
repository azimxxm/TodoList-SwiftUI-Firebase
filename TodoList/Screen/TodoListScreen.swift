//
//  TodoListScreen.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI
import SwiftData

struct TodoListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = TodoListScreenVM()
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Today")
                    .font(.title)
                    .foregroundStyle(.text)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("Hide isComplete") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                    viewModel.hideIscompleted.toggle()
                } }
                .foregroundStyle(.main.opacity(0.5))
                .buttonStyle(.plain)
            }
            .padding()
            
            List {
                DayFilterView(isSelectedDay: $viewModel.isSelectedDay)
                ForEach(viewModel.filtredData) { item in
                    NavigationLink {
                        Text(item.title)
                    } label: {
                        TodoListCell(item: item) {
                            item.isCompleted.toggle()
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.inset)
        }
        .alert(isPresented: $viewModel.showLogOutMenu, content: {
            Alert(title: Text("Log Out"), message: Text("Are you sure you want to log out?"))
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("November 19.2024")
                    .foregroundStyle(.textGray)
            }
            ToolbarItem(placement: .topBarTrailing) { addButton }
        }
        .background(Color.bg.ignoresSafeArea())
    }
    
    @ViewBuilder
    private var addButton: some View {
        Text("+ Add")
            .font(.subheadline)
            .padding(10)
            .background(.main.opacity(0.25))
            .cornerRadius(12)
            .onTapGesture { addItem() }
            .onLongPressGesture { viewModel.showLogOutMenu.toggle() }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = ItemDM(
                title: "Salom",
                details: nil,
                isCompleted: false,
                createdAt: Date()
            )
//            modelContext.insert(newItem)
            viewModel.items.append(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
//                modelContext.delete(viewModel.items[index])
                viewModel.items.remove(at: index)
            }
        }
    }
}

#Preview {
    TodoListScreen()
//        .modelContainer(for: ItemDM.self, inMemory: true)
}


import SwiftUI

extension View {
    
    /// Wrap a View in a Button and add a custom ButtonStyle.
    func asButton(scale: CGFloat = 0.95, opacity: Double = 1, brightness: Double = 0, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            self
        })
        .buttonStyle(ButtonStyleViewModifier(scale: scale, opacity: opacity, brightness: brightness))
    }
    
    @ViewBuilder
    func asButton(_ type: ButtonType = .tap, action: @escaping () -> Void) -> some View {
        switch type {
        case .press:
            self.asButton(scale: 0.975, action: action)
        case .opacity:
            self.asButton(scale: 1, opacity: 0.85, action: action)
        case .tap:
            self.onTapGesture {
                action()
            }
        }
    }
    
}

