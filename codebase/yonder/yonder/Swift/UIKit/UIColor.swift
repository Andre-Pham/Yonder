//
//  UIColor.swift
//  yonder
//
//  Created by Andre Pham on 27/5/2022.
//

import Foundation
import UIKit

// https://stackoverflow.com/a/38435309
extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var hex: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&hex)
        self.init(hex: Int(hex), alpha: alpha)
    }

    func adjustBrightness(by amount: CGFloat) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + amount, 1.0),
                           green: min(green + amount, 1.0),
                           blue: min(blue + amount, 1.0),
                           alpha: alpha)
        }
        else {
            return nil
        }
    }
    
}
