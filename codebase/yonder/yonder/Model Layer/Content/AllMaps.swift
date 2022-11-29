//
//  AllMaps.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

enum Maps {
    
    static func newMap() -> Map {
        let mapPool = MapPool(
            territoryPoolsInStageOrder: [
                TerritoryPool(
                    areaPools: [Areas.newTestAreaPool(1), Areas.newTestAreaPool(2)],
                    tavernAreas: [TavernAreas.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Areas.newTestAreaPool(3), Areas.newTestAreaPool(4)],
                    tavernAreas: [TavernAreas.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Areas.newTestAreaPool(5), Areas.newTestAreaPool(6)],
                    tavernAreas: [TavernAreas.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Areas.newTestAreaPool(7), Areas.newTestAreaPool(8)],
                    tavernAreas: [TavernAreas.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Areas.newTestAreaPool(9), Areas.newTestAreaPool(10)],
                    tavernAreas: [TavernAreas.newTestTavernArea()]
                ),
                TerritoryPool(
                    areaPools: [Areas.newTestAreaPool(11), Areas.newTestAreaPool(12)],
                    tavernAreas: [TavernAreas.newTestTavernArea()]
                ),
            ],
            bossAreaPoolsInOrder: [
                BossAreaPool(
                    bossLocations: [
                        BossLocation(boss: Foe(name: "Boss 1", description: "Big boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions())),
                        BossLocation(boss: Foe(name: "Boss 2", description: "Lil boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions()))
                    ],
                    restorerLocations: [RestorerLocation(restorer: Restorer(options: [.health, .armorPoints]))]
                ),
                BossAreaPool(
                    bossLocations: [
                        BossLocation(boss: Foe(name: "Boss 1", description: "Big boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions())),
                        BossLocation(boss: Foe(name: "Boss 2", description: "Lil boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions()))
                    ],
                    restorerLocations: [RestorerLocation(restorer: Restorer(options: [.health, .armorPoints]))]
                ),
                BossAreaPool(
                    bossLocations: [
                        BossLocation(boss: Foe(name: "Boss 1", description: "Big boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions())),
                        BossLocation(boss: Foe(name: "Boss 2", description: "Lil boss.", maxHealth: 10000, weapon: BaseAttack(damage: 1000), loot: NoLootOptions()))
                    ],
                    restorerLocations: [RestorerLocation(restorer: Restorer(options: [.health, .armorPoints]))]
                ),
            ])
        
        return MapGenerator().generateTerritoriesIntoMap(mapPool: mapPool)
    }
    
}
