//
//  FadeLoadingText.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import SwiftUI

struct FadeLoadingText: View {
    let text: String
    let size: YonderTextSize
    
    var body: some View {
        YonderText(text: self.text, size: self.size)
            .repeatFadingAnimation(duration: 0.5)
    }
}

#Preview {
    PreviewContentView {
        VStack(spacing: 40) {
            FadeLoadingText(text: "Testing", size: .title2)
            
            FadeLoadingText(text: "Testing", size: .cardSubscript)
        }
    }
}
