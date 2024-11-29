//
//  RegisterScreen.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct RegisterScreen: View {
    @StateObject private var viewModel = RegisterScreenVM()
    @Environment(\.router) private var router
    var body: some View {
        AuthorizationBaseScreen {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 50) {
                    VStack(spacing: 10) {
                        Text("Welcome Onboard!")
                            .font(.title)
                            .foregroundStyle(.text)
                            .fontWeight(.medium)
                        Text("Lets help you in completing your tasks")
                            .font(.subheadline)
                            .foregroundStyle(.textGray)
                    }
                    
                    VStack(spacing: 16) {
                        CustomTFWithHeaderView(
                            title: "Email",
                            placeholder: "hello@gmail.com",
                            text: $viewModel.email
                        )
                        CustomSTFWithHeaderView(
                            title: "Password",
                            placeholder: "*****",
                            text: $viewModel.password
                        )
                        CustomSTFWithHeaderView(
                            title: "Confirm password",
                            placeholder: "******",
                            text: $viewModel.confirmPassword
                        )
                    }
                    
                    ErrorStateView(errorMessage: viewModel.errorMessage)
                    
                    VStack(spacing: 16) {
                        ButtonView(title: "Register") { viewModel.register() }
                        HStack(spacing: 8) {
                            Text("Already have an account ?")
                            Button("Sign In", action: {
                                router.showScreen(.push) {_ in
                                    LoginScreen()
                                }
                            })
                            .foregroundStyle(.main)
                            .fontWeight(.medium)
                        }
                    }
                }
                .padding()
            }
            .safeAreaPadding(.top, 100)
            .onChange(of: viewModel.user) { _, newValue in
                if  newValue != nil {
                    router.showScreen(.fullScreenCover) { _ in
                        TodoListScreen()
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterScreen()
}
