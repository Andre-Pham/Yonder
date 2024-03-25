//
//  YonderActionWideButton.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2024.
//

import Foundation
import SwiftUI

struct YonderActionWideButton: View {
    let text: String
    var verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding
    var alignment: YonderButtonAlignment = .center
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderBorder5 {
                VStack {
                    switch self.alignment {
                    case .center:
                        YonderText(text: self.text, size: .buttonBody)
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
        }
    }
}

#Preview {
    PreviewContentView {
        YonderActionWideButton(text: "Do Something") { }
    }
}
