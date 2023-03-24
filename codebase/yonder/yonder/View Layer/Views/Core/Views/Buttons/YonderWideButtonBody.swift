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
    /// The animations permitted to be applied to the content
    private let permittedAnimations = [OptionsStateManager.animation]
    
    /// The button view
    private let content: () -> Content
    /// The vertical internal padding between the content and button frame
    var verticalPadding: CGFloat
    /// Code block called on button press
    let action: () -> Void
    
    init(verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Content) {
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
                .background(YonderColors.backgroundMaxDepth) // Ensures entire button can be tapped
                .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
                .transaction { transaction in
                    if !self.permittedAnimations.contains(where: { $0 == transaction.animation }) {
                        transaction.animation = nil
                    }
                }
        }
    }
}

struct YonderWideButtonBody_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            YonderWideButtonBody(verticalPadding: 10) {
                // Do something
            } label: {
                YonderText(text: "Button", size: .buttonBody)
            }
        }
    }
}
