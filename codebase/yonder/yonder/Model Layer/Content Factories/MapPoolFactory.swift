//
//  MapPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class MapPoolFactory {
    
    func build() -> MapPool {
        
        // MARK: IMPORTANT NOTE
        // The profile buckets need to be instantiated here and passed down
        // This is because each stage can't have overlapping profiles
        // Currently each stage is instantiating a new bucket
        
        let mapPool = MapPool(
            territoryPoolsInStageOrder: [
                
            ],
            bossAreas: [
                
            ]
        )
    }
    
}
