//
//  YonderFeedbackPopup.swift
//  yonder
//
//  Created by Andre Pham on 15/4/2022.
//

import Foundation
import SwiftUI

/// A popup that displays at the bottom of the parent view and displays text.
///
/// ``` @StateObject private var popupStateManager = PopupStateManager()
///     // ...
///     VStack {
///         Button("Show message!") {
///             self.popupStateManager.activatePopup()
///         }
///         // ...
///     }
///     .withFeedbackPopup(text: "Hello World", popupStateManager: self.popupStateManager)
/// ```
struct YonderFeedbackPopup: ViewModifier {
    
    public static let topBorderThickness = YonderBorder13Presets.topThickness
    public static let bottomBorderThickness = YonderBorder13Presets.bottomThickness
    public static let rightBorderThickness = YonderBorder13Presets.rightThickness
    public static let leftBorderThickness = YonderBorder13Presets.leftThickness
    public static var horizontalBorderThickness: Double {
        return Self.leftBorderThickness + Self.bottomBorderThickness
    }
    public static var verticalBorderThickness: Double {
        return Self.topBorderThickness + Self.bottomBorderThickness
    }
    
    let text: String
    let color: Color
    let padding: CGFloat
    @ObservedObject var popupStateManager: PopupStateManager
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            self.feedbackPopupView
        }
    }
    
    private var feedbackPopupView: some View {
        VStack {
            Spacer()
            
            if self.popupStateManager.isShowing {
                YonderBorder13 {
                    YonderText(
                        text: self.text,
                        size: .buttonBody,
                        color: self.color
                    )
                    .padding(14)
                    .frame(maxWidth: .infinity)
                }
                .padding(self.padding)
                .transition(.offset(y: 10).combined(with: .opacity))
                .onTapGesture {
                    self.popupStateManager.deactivatePopup()
                }
            }
        }
        .animation(
            .easeOut(duration: self.popupStateManager.transitionDuration),
            value: self.popupStateManager.isShowing
        )
    }
    
}
extension View {
    func withFeedbackPopup(
        text: String,
        color: Color = YonderColors.textMaxContrast,
        padding: CGFloat = YonderCoreGraphics.padding,
        popupStateManager: PopupStateManager
    ) -> some View {
        modifier(
            YonderFeedbackPopup(
                text: text,
                color: color,
                padding: padding,
                popupStateManager: popupStateManager
            )
        )
    }
}

#Preview {
    PreviewContentView {
        YonderBorder13 {
            YonderText(text: "Feedback", size: .buttonBody, color: YonderColors.textMaxContrast)
                .padding(14)
                .frame(maxWidth: .infinity)
        }
        .padding(YonderCoreGraphics.padding)
        .transition(.opacity)
    }
}
