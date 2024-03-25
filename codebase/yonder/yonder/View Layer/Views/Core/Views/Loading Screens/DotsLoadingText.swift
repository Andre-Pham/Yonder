//
//  DotsLoadingText.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import SwiftUI

struct DotsLoadingText: View {
    let text: String
    let size: YonderTextSize
    @State private var dotCount: Int = 0
    // Other timer implementations repeat forever even after view destruction
    let timer = SwiftUI.Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    var dots: String {
        String(repeating: ".", count: self.dotCount)
    }
    
    var body: some View {
        HStack(spacing: self.size.value*0.15) {
            YonderText(text: self.text, size: self.size)
            
            YonderText(text: self.dots, size: self.size)
                .onReceive(self.timer) { _ in
                    self.incrementDotCount()
                }
        }
    }
    
    func incrementDotCount() {
        self.dotCount = (self.dotCount + 1)%4
    }
}

#Preview {
    PreviewContentView {
        VStack(spacing: 40) {
            DotsLoadingText(text: "Testing", size: .title2)
            
            DotsLoadingText(text: "Testing", size: .cardSubscript)
        }
    }
}
