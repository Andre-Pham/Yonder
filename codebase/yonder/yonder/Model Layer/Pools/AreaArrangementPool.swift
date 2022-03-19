//
//  AreaArrangementPool.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

class AreaArrangementPool {
    
    private(set) var areaArrangements = [AreaArrangements]()
    
    init() {
        self.refillPool()
    }
    
    func refillPool() {
        for arrangement in AreaArrangements.allCases {
            self.areaArrangements.append(arrangement)
        }
    }
    
    func grabAreaArrangement() -> AreaArrangements {
        if self.areaArrangements.isEmpty {
            self.refillPool()
        }
        
        let arrangement = self.areaArrangements.randomElement()!
        if let index = self.areaArrangements.firstIndex(of: arrangement) {
            self.areaArrangements.remove(at: index)
        }
        
        return arrangement
    }
    
}
