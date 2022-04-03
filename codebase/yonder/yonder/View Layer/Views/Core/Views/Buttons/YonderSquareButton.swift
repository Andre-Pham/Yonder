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
    var verticalPadding: CGFloat = 13
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderText(text: self.text, size: .buttonBody)
                .frame(width: YonderTextSize.buttonBody.value + self.verticalPadding*2)
                .padding(.vertical, self.verticalPadding)
                .background(Color.Yonder.backgroundMaxDepth) // Ensures entire button can be tapped
                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}
