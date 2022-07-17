//
//  LootOptions.swift
//  yonder
//
//  Created by Andre Pham on 13/7/2022.
//

import Foundation

class LootOptions {
    
    let option1: LootBag
    let option2: LootBag
    let option3: LootBag
    var lootBags: [LootBag] {
        return [self.option1, self.option2, self.option3]
    }
    @DidSetPublished private(set) var isLooted = false
    
    init(_ option1: LootBag, _ option2: LootBag, _ option3: LootBag) {
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        
        if option2.name == option1.name {
            option2.reassignName()
        }
        if option3.name == option2.name || option3.name == option1.name {
            option3.reassignName(banned: [option2.name, option1.name])
        }
    }
    
    func take(_ option: UUID, player: Player) {
        if let loot = self.lootBags.first(where: { $0.id == option }) {
            player.setLoot(to: loot)
            self.isLooted = true
        } else {
            assertionFailure("Player is trying to select loot that doesn't exist")
        }
    }
    
}
