//
//  UIColorExtensions.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import Foundation
import SwiftUI

// https://stackoverflow.com/a/38435309
extension UIColor {

    func adjust(by amount: CGFloat) -> UIColor? {
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
