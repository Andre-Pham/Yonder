//
//  NoItem.swift
//  yonder
//
//  Created by Andre Pham on 15/6/2022.
//

import Foundation

class NoItem: Item {
    
    init() {
        super.init(name: "NO_ITEM", description: "NO_ITEM_DESCRIPTION")
    }
    
    func getEffectsDescription() -> String? {
        return nil
    }
    
}
