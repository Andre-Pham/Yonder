//
//  YonderWideButtonBody.swift
//  yonder
//
//  Created by Andre Pham on 3/4/2022.
//

import Foundation
import SwiftUI

/// Yonder-themed button that leaves the inside content of the button up to customisation.
/// Ideal for when buttons need to contain content that is too custom to be generic.
///
/// Example:
/// ``` YonderWideButtonBody {
///         print("Pressed!")
///     } label: {
///         YonderText(text: "Press Me", size: .buttonBody)
///     }
/// ```
struct YonderWideButtonBody<Content: View>: View {
    private let content: () -> Content
    
    var verticalPadding: CGFloat
    
    let action: () -> Void
    
    init(verticalPadding: CGFloat = 13, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Content) {
        self.verticalPadding = verticalPadding
        self.action = action
        self.content = label
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            content()
                .frame(maxWidth: .infinity)
                .padding(.vertical, self.verticalPadding)
                .background(Color.Yonder.backgroundMaxDepth) // Ensures entire button can be tapped
                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}
