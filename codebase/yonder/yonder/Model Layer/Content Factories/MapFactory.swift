//
//  MapFactory.swift
//  yonder
//
//  Created by Andre Pham on 1/12/2022.
//

import Foundation

class MapFactory {
    
    func deliver() -> Map {
        let mapPool = MapPoolFactory().deliver()
        return MapGenerator().generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
}
