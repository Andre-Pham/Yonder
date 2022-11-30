//
//  StatRange.swift
//  yonder
//
//  Created by Andre Pham on 20/11/2022.
//

import Foundation

/// Defines a range. Used to select a value from a distribution during content generation.
class StatRange {

    private(set) var min: Double
    var minInt: Int { self.min.toRoundedInt() }
    private(set) var max: Double
    var maxInt: Int { self.max.toRoundedInt() }

    init(min: Double, max: Double) {
        assert(min <= max, "min <= max required")
        self.min = min
        self.max = max
    }
    
    init(min: Int, max: Int) {
        assert(min <= max, "min <= max required")
        self.min = Double(min)
        self.max = Double(max)
    }
    
    init(target: Int, boundFraction: Double) {
        let boundMidDifference = (Double(target)*boundFraction)
        self.min = Double(target) - boundMidDifference
        self.max = Double(target) + boundMidDifference
    }

    @discardableResult
    func compound(multiply: Double, index: Int) -> Self {
        self.min = self.min.compound(multiply: multiply, index: index)
        self.max = self.max.compound(multiply: multiply, index: index)
        return self
    }

    func selectFromLinearDistribution(minY: Double, maxY: Double) -> Double {
        return Random.selectFromLinearDistribution(min: self.min, max: self.max, minY: minY, maxY: maxY)
    }
    
    func selectFromNormalDistribution() -> Int {
        return Random.selectFromNormalDistribution(min: self.minInt, max: self.maxInt)
    }
    
    func selectFromNormalDistribution() -> Double {
        return Random.selectFromNormalDistribution(min: self.min, max: self.max)
    }

}
