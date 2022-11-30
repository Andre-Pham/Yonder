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
            name: Strings("restorer.postBoss.name").local,
            description: Strings("restorer.postBoss.description").local,
            options: [.armorPoints, .health],
            pricePerHealthBundle: 0,
            pricePerArmorPointBundle: 0
        )
        let bossOptions = Bosses.allBossOptions(boss: bossNumber)
        return BossAreaPool(
            bossLocations: bossOptions.map { BossLocation(boss: $0) },
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
