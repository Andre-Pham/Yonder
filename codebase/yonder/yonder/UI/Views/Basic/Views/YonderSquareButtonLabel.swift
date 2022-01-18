//
//  YonderSquareButtonLabel.swift
//  yonder
//
//  Created by Andre Pham on 17/1/2022.
//

import Foundation
import SwiftUI

struct YonderSquareButtonLabel: View {
    let text: String
    var sideLength: CGFloat = 50
    
    var body: some View {
        YonderRectButtonLabel(text: self.text, width: self.sideLength, height: self.sideLength)
    }
}
