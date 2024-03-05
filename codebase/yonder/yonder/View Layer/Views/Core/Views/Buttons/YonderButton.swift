//
//  YonderButton.swift
//  yonder
//
//  Created by Andre Pham on 3/4/2022.
//

import Foundation
import SwiftUI

struct YonderButton: View {
    let text: String
    var width: CGFloat = 200
    var verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderBorder3 {
                YonderText(text: self.text, size: .buttonBody)
                    .frame(width: self.width)
                    .padding(.vertical, self.verticalPadding)
            }
        }
    }
}

#Preview {
    PreviewContentView {
        YonderButton(text: "Hello World") { }
    }
}
