//
//  Color.swift
//  yonder
//
//  Created by Andre Pham on 27/5/2022.
//

import Foundation
import SwiftUI

extension Color {
    
    func adjustedBrightness(by amount: Double) -> Color {
        return Color(UIColor(self).adjust(by: amount) ?? .red)
    }
    
}
