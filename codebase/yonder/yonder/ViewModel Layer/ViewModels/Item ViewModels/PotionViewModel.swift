//
//  PotionViewModel.swift
//  yonder
//
//  Created by Andre Pham on 21/2/2022.
//

import Foundation
import Combine

class PotionViewModel: ItemViewModel {
    
    init(_ potion: Potion) {
        super.init(potion,
                   remainingUsesDescription: Strings("stat.potion.remainingUses").local,
                   damageImage: YonderIcons.potionDamageIcon,
                   restorationImage: YonderIcons.potionRestorationIcon,
                   healthRestorationImage: YonderIcons.potionHealthRestorationIcon,
                   armorPointsRestorationImage: YonderIcons.potionArmorPointsRestorationIcon,
                   remainingUsesImage: YonderIcons.potionRemainingUsesIcon)
        self.setEffectsDescription(to: potion.getEffectsDescription())
    }
    
}
