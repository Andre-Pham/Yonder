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
    var height: CGFloat = 50
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderText(text: self.text, size: .buttonBody)
                .frame(width: self.width, height: self.height)
                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}

struct YonderWideButton: View {
    let text: String
    var height: CGFloat = 50
    var alignment: YonderButtonAlignment = .center
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: self.height)
                    .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                
                switch self.alignment {
                case .center:
                    YonderText(text: self.text, size: .buttonBody)
                case .leading:
                    HStack {
                        YonderText(text: self.text, size: .buttonBody)
                            .padding(.leading)
                        
                        Spacer()
                    }
                case .trailing:
                    HStack {
                        Spacer()
                        
                        YonderText(text: self.text, size: .buttonBody)
                            .padding(.trailing)
                    }
                }
            }
        }
        .buttonStyle(YonderButtonStyle())
    }
}

struct YonderSquareButton: View {
    let text: String
    var sideLength: CGFloat = 50
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            YonderText(text: self.text, size: .buttonBody)
                .frame(width: self.sideLength, height: self.sideLength)
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
