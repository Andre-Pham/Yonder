//
//  AreaProfileTagAllocation.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class AreaProfileTagAllocation {
    
    private let tags: [AreaProfileTag]
    private let weights: [Int]
    private var count: Int {
        return self.tags.count
    }
    
    init(tags: (AreaProfileTag, Int)...) {
        self.tags = tags.map { $0.0 }
        self.weights = tags.map { $0.1 }
        assert(self.weights.allSatisfy({ $0 > 0 }), "negative weight provided")
    }
    
    func getTag() -> AreaProfileTag {
        let index = FactoryUtil.randomWeightedIndex(self.weights)
        return self.tags[index]
    }
    
}
