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
    var verticalPadding: CGFloat = 13
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderText(text: self.text, size: .buttonBody)
                .frame(width: self.width)
                .padding(.vertical, self.verticalPadding)
                .background(Color.Yonder.backgroundMaxDepth) // Ensures entire button can be tapped
                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}
