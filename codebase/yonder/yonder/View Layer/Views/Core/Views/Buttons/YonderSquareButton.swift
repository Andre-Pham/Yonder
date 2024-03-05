//
//  YonderSquareButton.swift
//  yonder
//
//  Created by Andre Pham on 7/2/2022.
//

import Foundation
import SwiftUI

struct YonderSquareButton: View {
    let text: String
    var verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderBorder3 {
                YonderText(text: self.text, size: .buttonBody)
                    .frame(width: YonderTextSize.buttonBody.value + self.verticalPadding*2)
                    .padding(.vertical, self.verticalPadding)
            }
        }
    }
}

#Preview {
    PreviewContentView {
        YonderSquareButton(text: "i") { }
    }
}
