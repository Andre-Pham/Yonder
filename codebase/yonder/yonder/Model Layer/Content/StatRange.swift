//
//  StatRange.swift
//  yonder
//
//  Created by Andre Pham on 20/11/2022.
//

import Foundation

/// Defines a range. Used to select a value from a linear distribution during content generation.
class StatRange {

    private(set) var min: Double
    var minInt: Int { self.min.toRoundedInt() }
    private(set) var max: Double
    var maxInt: Int { self.max.toRoundedInt() }

    init(min: Double, max: Double) {
        self.min = min
        self.max = max
    }
    
    init(min: Int, max: Int) {
        self.min = Double(min)
        self.max = Double(max)
    }

    func compound(multiply: Double, index: Int) {
        self.min = self.min.compound(multiply: multiply, index: index)
        self.max = self.max.compound(multiply: multiply, index: index)
    }

    func selectFromLinearDistribution(minY: Double, maxY: Double) -> Double {
        return Random.selectFromLinearDistribution(min: self.min, max: self.max, minY: minY, maxY: maxY)
    }

}
