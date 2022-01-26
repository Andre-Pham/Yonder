//
//  ColorManipulation.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import Foundation
import SwiftUI

enum ColorManipulation {
    
    static func adjustBrightness(of color: Color, amount: Double) -> Color {
        return Color(UIColor(color).adjust(by: amount) ?? .red)
    }
    
}
