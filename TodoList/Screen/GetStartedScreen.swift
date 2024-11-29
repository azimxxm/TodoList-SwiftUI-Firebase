//
//  GetStartedScreen.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct GetStartedScreen: View {
    @Environment(\.router) private var router
    var body: some View {
        AuthorizationBaseScreen {
            GeometryReader { proxy in
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: proxy.size.width * 0.4, height: proxy.size.height * 0.4)
                            .clipped()
                        Text("Get things done with TODO")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.text)
                            .lineLimit(2)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed posuere gravida purus id eu condimentum est diam quam. Condimentum blandit diam.")
                            .font(.headline)
                            .foregroundStyle(.textGray)
                            .padding()
                    }
                }
                .safeAreaInset(edge: .bottom, content: {
                    ButtonView(action: {
                        router.showScreen(.push) { _ in
                            RegisterScreen()
                        }
                    })
                    .padding()
                    
                })
                .padding()
            }
        }
    }
}

#Preview {
    GetStartedScreen()
}
