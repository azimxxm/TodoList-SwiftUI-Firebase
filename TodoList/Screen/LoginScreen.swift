//
//  LoginScreen.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var viewModel = LoginScreenVM()
    @Environment(\.router) private var router
    var body: some View {
        AuthorizationBaseScreen {
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Text("Welcome Back!")
                            .font(.title)
                            .foregroundStyle(.text)
                            .fontWeight(.medium)
                        Image(.loginIlustration)
                            .resizable()
                            .scaledToFit()
                            .frame(width: proxy.size.width * 0.5, height: proxy.size.height * 0.4)
                        CustomTFWithHeaderView(title: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                            .padding(.bottom)
                        CustomSTFWithHeaderView(title: "Password", text: $viewModel.password)
                        Button("Forgot Password?") {
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundStyle(.main)
                        .fontWeight(.medium)
                        .padding(10)
                        VStack(spacing: 16) {
                            ButtonView(title: "Login") { viewModel.login() }
                            HStack(spacing: 8) {
                                Text("Don’t have an account ?")
                                Button("Sign Up", action: { router.dismissScreen()  })
                                .foregroundStyle(.main)
                                .fontWeight(.medium)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onChange(of: viewModel.user) { _, newValue in
            if newValue != nil {
                router.showScreen(.fullScreenCover) {_ in
                    TodoListScreen()
                }
            }
        }
    }
}

#Preview {
    LoginScreen()
}
