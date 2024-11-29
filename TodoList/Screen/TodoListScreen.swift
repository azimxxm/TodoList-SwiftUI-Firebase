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
            DayFilterView(isSelectedDay: $viewModel.isSelectedDay)
            todoList

        }
        .alert(isPresented: $viewModel.showLogOutMenu, content: {
            Alert(title: Text("Log Out"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Yes"), action: { viewModel.logout() }))
        })
        .alert("Add new item", isPresented: $viewModel.showFormView, actions: {
            AddNewTodosAlertView { item in addItem(item) }
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("November 19.2024")
                    .foregroundStyle(.textGray)
            }
            ToolbarItem(placement: .topBarTrailing) { addButton }
        }
    }
    
    @ViewBuilder
    private var todoList: some View {
        List {
            ForEach(viewModel.filtredData) { item in
                NavigationLink {
                    VStack(spacing: 16) {
                        Text(item.title)
                        if let detail = item.details {
                            Text(detail)
                        }
                    }
                } label: {
                    TodoListCell(item: item) {
                        item.isCompleted.toggle()
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
    }
    
    @ViewBuilder
    private var addButton: some View {
        Text("+ Add")
            .font(.subheadline)
            .padding(10)
            .background(.main.opacity(0.25))
            .cornerRadius(12)
            .onTapGesture { viewModel.showFormView.toggle() }
            .onLongPressGesture { viewModel.showLogOutMenu.toggle() }
        
    }

    private func addItem(_ item: ItemDM) {
        withAnimation {
            viewModel.items.append(item)
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

