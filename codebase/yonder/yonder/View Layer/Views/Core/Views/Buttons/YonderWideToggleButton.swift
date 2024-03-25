//
//  YonderWideToggleButton.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2024.
//

import SwiftUI

struct YonderWideToggleButton: View {
    let activatedText: String
    let deactivatedText: String
    var verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding
    var alignment: YonderButtonAlignment = .center
    let isActivated: Bool
    private var text: String {
        return self.isActivated ? self.activatedText : self.deactivatedText
    }
    
    let action: () -> Void
    
    var buttonContent: some View {
        VStack {
            switch self.alignment {
            case .center:
                YonderText(
                    text: self.text,
                    size: .buttonBody
                )
                    .padding(.horizontal)
            case .leading:
                HStack {
                    YonderText(text: self.text, size: .buttonBody)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            case .trailing:
                HStack {
                    Spacer()
                    
                    YonderText(text: self.text, size: .buttonBody)
                        .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, self.verticalPadding)
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            if self.isActivated {
                YonderBorder3 {
                    self.buttonContent
                }
            } else {
                YonderBorder5 {
                    self.buttonContent
                }
            }
        }
    }
}

#Preview {
    PreviewContentView {
        YonderWideToggleButton(activatedText: "Activated", deactivatedText: "Deactivated", isActivated: true) { }
    }
}
