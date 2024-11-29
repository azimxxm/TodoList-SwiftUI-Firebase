//
//  AuthorizationBaseScreen.swift
//  TodoList
//
//  Created by Azimjon Abdurasulov on 29/11/24.
//

import SwiftUI

struct AuthorizationBaseScreen<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: ()-> Content) {
        self.content = content()
    }
    var body: some View {
        GeometryReader { proxy in
            Color.bg.ignoresSafeArea()
            ZStack(alignment: .topLeading) {
                Image(.circleShape)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .ignoresSafeArea()
            }
            content
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

#Preview {
    AuthorizationBaseScreen() {
        Text("Some text")
    }
}


