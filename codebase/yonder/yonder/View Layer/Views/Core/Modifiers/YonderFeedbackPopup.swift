//
//  YonderFeedbackPopup.swift
//  yonder
//
//  Created by Andre Pham on 15/4/2022.
//

import Foundation
import SwiftUI

struct YonderFeedbackPopup: ViewModifier {
    
    enum PopupDuration: Double {
        case short = 2
        case long = 3.5
    }
    
    let text: String
    let duration: PopupDuration
    @ObservedObject var popupStateManager: PopupStateManager
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            feedbackPopupView
        }
    }
    
    private var feedbackPopupView: some View {
        VStack {
            Spacer()
            
            if self.popupStateManager.isShowing {
                Group {
                    YonderText(text: self.text, size: .buttonBody, color: .yellow)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.Yonder.backgroundMaxDepth)
                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                .padding(YonderCoreGraphics.padding)
                .transition(.opacity)
                .onTapGesture {
                    self.popupStateManager.deactivatePopup()
                }
            }
        }
        .animation(.linear(duration: 0.2), value: self.popupStateManager.isShowing)
    }
    
}
extension View {
    func withFeedbackPopup(text: String, popupStateManager: PopupStateManager, duration: YonderFeedbackPopup.PopupDuration = .short) -> some View {
        modifier(YonderFeedbackPopup(text: text, duration: duration, popupStateManager: popupStateManager))
    }
}
