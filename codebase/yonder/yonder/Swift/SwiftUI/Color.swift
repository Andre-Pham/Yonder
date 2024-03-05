//
//  Color.swift
//  yonder
//
//  Created by Andre Pham on 27/5/2022.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(uiColor: UIColor(hex: hex, alpha: alpha))
    }
    
    init(hexString: String, alpha: CGFloat = 1.0) {
        self.init(uiColor: UIColor(hexString: hexString, alpha: alpha))
    }
    
    func adjustedBrightness(by amount: Double) -> Color {
        guard let adjusted = UIColor(self).adjustBrightness(by: amount) else {
            assertionFailure("Failed to adjust color")
            return .red
        }
        return Color(adjusted)
    }
    
}
