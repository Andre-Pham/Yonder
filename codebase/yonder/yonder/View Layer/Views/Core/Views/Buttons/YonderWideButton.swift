//
//  YonderWideButton.swift
//  yonder
//
//  Created by Andre Pham on 3/4/2022.
//

import Foundation
import SwiftUI

struct YonderWideButton: View {
    let text: String
    var verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding
    var alignment: YonderButtonAlignment = .center
    
    let action: () -> Void
    
    var body: some View {
        YonderMultilineWideButton(text: [self.text], verticalPadding: self.verticalPadding, alignment: self.alignment) {
            action()
        }
    }
}
