//
//  YonderWideButtonLabel.swift
//  yonder
//
//  Created by Andre Pham on 29/1/2022.
//

import Foundation
import SwiftUI

struct YonderWideButtonLabel: View {
    let text: String
    var height: CGFloat = 50
    
    var body: some View {
        YonderText(text: self.text, size: .buttonBody)
            .frame(maxWidth: .infinity)
            .frame(height: self.height)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
