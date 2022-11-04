//
//  LootButtonBody.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct LootButton: View {
    let text: String
    let collectText: String
    var infoButton: Bool = false
    let onSelect: () -> Void
    var onInfo: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading) {
            YonderText(text: self.text, size: .buttonBody)
            
            HStack {
                if self.infoButton {
                    YonderWideButton(text: Strings("button.info").local) {
                        self.onInfo()
                    }
                }
                
                YonderWideButton(text: self.collectText) {
                    self.onSelect()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(YonderCoreGraphics.padding)
        .background(YonderColors.backgroundMaxDepth)
        .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
    }
}

struct LootButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            LootButton(text: "Cool Gear", collectText: "Equip", infoButton: true) {
                
            } onInfo: {
                
            }
        }
    }
}
