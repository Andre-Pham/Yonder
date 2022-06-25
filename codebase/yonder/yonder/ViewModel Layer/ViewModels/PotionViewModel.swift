//
//  PotionViewModel.swift
//  yonder
//
//  Created by Andre Pham on 21/2/2022.
//

import Foundation
import Combine

class PotionViewModel: ItemViewModel {
    
    init(_ potion: PotionAbstract) {
        super.init(potion,
                   remainingUsesDescription: Strings.Stat.Potion.RemainingUses.local,
                   damageImage: YonderImages.potionDamageIcon,
                   healthRestorationImage: YonderImages.potionHealthRestorationIcon,
                   armorPointsRestorationImage: YonderImages.potionArmorPointsRestorationIcon,
                   remainingUsesImage: YonderImages.potionRemainingUsesIcon)
        self.setEffectsDescription(to: potion.getEffectsDescription())
    }
    
}
