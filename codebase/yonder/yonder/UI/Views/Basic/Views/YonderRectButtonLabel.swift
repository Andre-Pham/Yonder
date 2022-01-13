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
    
    var body: some View {
        YonderText(text: self.text, size: .buttonBody)
            .frame(width: 200, height: 50)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
