//
//  ConsumableViewModel.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import Foundation
import Combine

class ConsumableViewModel: ItemViewModel {
    
    init(_ consumable: Consumable) {
        super.init(consumable,
                   remainingUsesDescription: Strings("stat.consumable.remainingUses").local,
                   damageImage: YonderIcons.consumableDamageIcon,
                   restorationImage: YonderIcons.consumableRestorationIcon,
                   healthRestorationImage: YonderIcons.consumableHealthRestorationIcon,
                   armorPointsRestorationImage: YonderIcons.consumableArmorPointsRestorationIcon,
                   remainingUsesImage: YonderIcons.consumableRemainingUsesIcon)
        self.setEffectsDescription(to: consumable.effectsDescription)
        
        consumable.$effectsDescription.sink(receiveValue: { newValue in
            self.setEffectsDescription(to: newValue)
        }).store(in: &self.subscriptions)
    }
    
}
