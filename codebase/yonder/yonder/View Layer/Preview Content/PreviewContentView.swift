//
//  PreviewContentView.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct PreviewContentView<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            self.content()
                .padding()
        }
    }
}

struct PreviewContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView() {
            YonderText(text: "Hello World", size: .buttonBody)
        }
    }
}
