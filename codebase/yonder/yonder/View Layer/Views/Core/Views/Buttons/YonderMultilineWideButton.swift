//
//  YonderMultilineWideButton.swift
//  yonder
//
//  Created by Andre Pham on 3/4/2022.
//

import Foundation
import SwiftUI

struct YonderMultilineWideButton: View {
    let text: [String]
    var isMultiline: Bool {
        return self.text.count > 1
    }
    var verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding
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
                            .padding(.bottom, index == 0 && self.isMultiline ? YonderCoreGraphics.buttonTitleSpacing : 0)
                    }
                case .leading:
                    ForEach(Array(zip(self.text.indices, self.text)), id: \.0.self) { index, text in
                        HStack {
                            YonderText(text: text, size: index == 0 ? .buttonBody : .buttonBodySubscript)
                                .padding(.leading)
                                .padding(.bottom, index == 0 && self.isMultiline ? YonderCoreGraphics.buttonTitleSpacing : 0)
                            
                            Spacer()
                        }
                    }
                case .trailing:
                    ForEach(Array(zip(self.text.indices, self.text)), id: \.0.self) { index, text in
                        HStack {
                            Spacer()
                            
                            YonderText(text: text, size: index == 0 ? .buttonBody : .buttonBodySubscript)
                                .padding(.trailing)
                                .padding(.bottom, index == 0 && self.isMultiline ? YonderCoreGraphics.buttonTitleSpacing : 0)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, self.verticalPadding)
            .background(Color.Yonder.backgroundMaxDepth) // Ensures entire button can be tapped
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}
