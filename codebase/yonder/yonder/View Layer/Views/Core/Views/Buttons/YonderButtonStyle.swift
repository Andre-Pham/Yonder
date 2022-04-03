//
//  YonderButtonStyle.swift
//  yonder
//
//  Created by Andre Pham on 3/4/2022.
//

import Foundation
import SwiftUI

/// A style that dims a button's label view after tapping it.
/// Currently not used. If you want multi-layered buttons to have both the selected and unselected layers dimmed when tapping, add this to the button.
/// ``` Button {
///         // Code
///     } label: {
///         // View
///     }
///     .buttonStyle(YonderButtonStyle())
/// ```
struct YonderButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed ? YonderCoreGraphics.selectedButtonBrightness : 0)
    }
}
