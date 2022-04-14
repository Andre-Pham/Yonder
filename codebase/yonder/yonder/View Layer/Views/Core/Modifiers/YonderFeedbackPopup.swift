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
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            feedbackPopupView
        }
    }
    
    private var feedbackPopupView: some View {
        VStack {
            Spacer()
            
            if self.isShowing {
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
                    self.isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.duration.rawValue) {
                        self.isShowing = false
                    }
                }
            }
        }
        .animation(.linear(duration: 0.3), value: self.isShowing)
    }
    
}
extension View {
    func withFeedbackPopup(text: String, isShowing: Binding<Bool>, duration: YonderFeedbackPopup.PopupDuration = .short) -> some View {
        modifier(YonderFeedbackPopup(text: text, duration: duration, isShowing: isShowing))
    }
}
