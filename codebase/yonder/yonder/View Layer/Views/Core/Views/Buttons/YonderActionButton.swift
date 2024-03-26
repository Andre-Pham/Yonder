//
//  YonderActionButton.swift
//  yonder
//
//  Created by Andre Pham on 27/3/2024.
//

import Foundation
import SwiftUI

struct YonderActionButton: View {
    let text: String
    var width: CGFloat = 200
    var verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderBorder5 {
                YonderText(text: self.text, size: .buttonBody)
                    .frame(width: self.width)
                    .padding(.vertical, self.verticalPadding)
            }
        }
    }
}

#Preview {
    PreviewContentView {
        YonderActionButton(text: "Hello World") { }
    }
}
