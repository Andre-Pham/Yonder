//
//  BossAreaPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 30/11/2022.
//

import Foundation

class BossAreaPoolFactory {
    
    func deliver(bossNumber: Int) -> BossAreaPool {
        // The same restorer that tends to you after every boss fight
        let restorer = Restorer(
            contentID: "N0020", // Reserved content ID
            name: Strings("restorer.postBoss.name").local,
            description: Strings("restorer.postBoss.description").local,
            options: [.armorPoints, .health],
            pricePerHealthBundle: 0,
            pricePerArmorPointBundle: 0
        )
        // If you wanted to have pre-determined defined bosses, you could put them here and inject them into the boss locations
        // (bossLocations takes multiple boss locations to select from, if desired)
        // Locations don't generate content if they're initialised with it
        return BossAreaPool(
            bossLocations: [BossLocation()],
            restorerLocations: [RestorerLocation(restorer: restorer)]
        )
    }
    
    func deliver(count: Int) -> [BossAreaPool] {
        var bossAreaPools = [BossAreaPool]()
        for bossNumber in 0..<count {
            bossAreaPools.append(self.deliver(bossNumber: bossNumber))
        }
        return bossAreaPools
    }
    
}
