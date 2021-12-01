//
//  PricePercentBuff.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class PricePercentBuff: BuffAbstract {
    
    private let priceFraction: Double
    
    init(duration: Int, priceFraction: Double) {
        self.priceFraction = priceFraction
        
        super.init(duration: duration, type: .health, priority: 1)
    }
    
    override func applyPrice(to gold: Int) -> Int? {
        return Int(round(Double(gold)*self.priceFraction))
    }
    
}
