//
//  NoLootOptions.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import Foundation

class NoLootOptions: LootOptions {
    
    init() {
        super.init(LootBag(), LootBag(), LootBag())
    }
    
}
