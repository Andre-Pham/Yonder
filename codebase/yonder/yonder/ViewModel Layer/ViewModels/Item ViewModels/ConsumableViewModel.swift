//
//  ConsumableViewModel.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import Foundation
import Combine

class ConsumableViewModel: ItemViewModel {
    
    init(_ consumable: ConsumableAbstract) {
        super.init(consumable,
                   remainingUsesDescription: Strings.Stat.Consumable.RemainingUses.local,
                   damageImage: YonderImages.consumableDamageIcon,
                   restorationImage: YonderImages.consumableRestorationIcon,
                   healthRestorationImage: YonderImages.consumableHealthRestorationIcon,
                   armorPointsRestorationImage: YonderImages.consumableArmorPointsRestorationIcon,
                   remainingUsesImage: YonderImages.consumableRemainingUsesIcon)
        self.setEffectsDescription(to: consumable.effectsDescription)
        
        consumable.$effectsDescription.sink(receiveValue: { newValue in
            self.setEffectsDescription(to: newValue)
        }).store(in: &self.subscriptions)
    }
    
}
