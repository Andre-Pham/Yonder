//
//  InventoryStateManager.swift
//  yonder
//
//  Created by Andre Pham on 3/4/2022.
//

import Foundation
import SwiftUI

class InventoryStateManager: ObservableObject {
    
    @Published private(set) var weaponsActive = false
    @Published private(set) var potionsActive = false
    @Published private(set) var consumablesActive = false
    @Published private var optionHeaderText: String? = nil
    var optionHeader: String? {
        if let text = self.optionHeaderText {
            return "[\(text)]"
        }
        return nil
    }
    
    private func disableAll() {
        self.weaponsActive = false
        self.potionsActive = false
        self.consumablesActive = false
    }
    
    func weaponOptionSelected(weaponCount: Int) {
        if (self.weaponsActive) {
            self.weaponsActive = false
            self.optionHeaderText = nil
        } else {
            self.disableAll()
            self.weaponsActive = true
            self.optionHeaderText = Strings("inventory.weapons.header").local
            if weaponCount == 0 {
                self.optionHeaderText = Strings("inventory.weapons.headerZeroWeapons").local
            }
        }
    }
    
    func potionOptionSelected(potionCount: Int) {
        if (self.potionsActive) {
            self.potionsActive = false
            self.optionHeaderText = nil
        } else {
            self.disableAll()
            self.potionsActive = true
            self.optionHeaderText = Strings("inventory.potions.header").local
            if potionCount == 0 {
                self.optionHeaderText = Strings("inventory.potions.headerZeroPotions").local
            }
        }
    }
    
    func consumableOptionSelected(consumableCount: Int) {
        if (self.consumablesActive) {
            self.consumablesActive = false
            self.optionHeaderText = nil
        } else {
            self.disableAll()
            self.consumablesActive = true
            self.optionHeaderText = Strings("inventory.consumables.header").local
            if consumableCount == 0 {
                self.optionHeaderText = Strings("inventory.consumables.headerZeroConsumables").local
            }
        }
    }
    
}
