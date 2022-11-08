//
//  LootBagFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class LootBagFactory {
    
    func buildLootBags(stage: Int, count: Int, tags: AreaProfileTagAllocation) -> [LootBag] {
        
        // I need "types" of loot bags, just like I have "types" of foes
        // (i don't want a loot bag that's literally just gold)
        // these types will keep adding items generated from factories until they reach a threshold total value
        // then it returns the loot bag
        // that means before i can do this, i need to create factories for armor, potions, weapons, and accessories
        
        
        let bag = LootBag()
        bag.addGoldLoot(<#T##gold: Int##Int#>)
        bag.addArmorLoot(<#T##armor: Armor##Armor#>)
        bag.addPotionLoot(<#T##potion: Potion##Potion#>)
        bag.addWeaponLoot(<#T##weapon: Weapon##Weapon#>)
        bag.addAccessoryLoot(<#T##accessory: Accessory##Accessory#>)
        while bag.
                
        LootOptions
    }
    
}
