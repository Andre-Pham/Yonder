//
//  Double.swift
//  yonder
//
//  Created by Andre Pham on 18/6/2022.
//

import Foundation

extension Double {
    
    func toString(decimalPlaces: Int = 0) -> String {
        return NSString(format: "%.\(decimalPlaces)f" as NSString, self) as String
    }
    
    func multiplyingIncreases() -> Bool {
        return self > 1
    }
    
    func multiplyingDecreases() -> Bool {
        return self >= 0 && self < 1
    }
    
}
