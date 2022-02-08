//
//  YonderButtons.swift
//  yonder
//
//  Created by Andre Pham on 7/2/2022.
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
                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}

struct YonderWideButton: View {
    let text: String
    var verticalPadding: CGFloat = 13
    var alignment: YonderButtonAlignment = .center
    
    let action: () -> Void
    
    var body: some View {
        YonderMultilineWideButton(text: [self.text], verticalPadding: self.verticalPadding, alignment: self.alignment) {
            action()
        }
    }
}

struct YonderMultilineWideButton: View {
    let text: [String]
    var verticalPadding: CGFloat = 13
    var alignment: YonderButtonAlignment = .center
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                switch self.alignment {
                case .center:
                    ForEach(Array(zip(self.text.indices, self.text)), id: \.0.self) { index, text in
                        YonderText(text: text, size: index == 0 ? .buttonBody : .buttonBodySubscript)
                    }
                case .leading:
                    ForEach(Array(zip(self.text.indices, self.text)), id: \.0.self) { index, text in
                        HStack {
                            YonderText(text: text, size: index == 0 ? .buttonBody : .buttonBodySubscript)
                                .padding(.leading)
                            
                            Spacer()
                        }
                    }
                case .trailing:
                    ForEach(Array(zip(self.text.indices, self.text)), id: \.0.self) { index, text in
                        HStack {
                            Spacer()
                            
                            YonderText(text: text, size: index == 0 ? .buttonBody : .buttonBodySubscript)
                                .padding(.trailing)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, self.verticalPadding)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
        .buttonStyle(YonderButtonStyle())
    }
}

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
                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}

enum YonderButtonAlignment {
    case leading
    case center
    case trailing
}

struct YonderButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed ? YonderCoreGraphics.selectedButtonBrightness : 0)
    }
}
