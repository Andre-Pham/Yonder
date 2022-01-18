//
//  YonderRectButtonLabel.swift
//  yonder
//
//  Created by Andre Pham on 29/12/21.
//

import Foundation
import SwiftUI

struct YonderRectButtonLabel: View {
    let text: String
    var width: CGFloat = 200
    var height: CGFloat = 50
    
    var body: some View {
        YonderText(text: self.text, size: .buttonBody)
            .frame(width: self.width, height: self.height)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
