//
//  WeaponViewModel.swift
//  yonder
//
//  Created by Andre Pham on 3/2/2022.
//

import Foundation
import Combine
import SwiftUI

class WeaponViewModel: ItemViewModel {
    
    @Published private(set) var previewEffectsDescription: String?
    
    init(_ weapon: Weapon) {
        super.init(weapon,
                   remainingUsesDescription: Strings.Stat.Weapon.RemainingUses.local,
                   damageImage: YonderImages.weaponDamageIcon,
                   restorationImage: YonderImages.weaponRestorationIcon,
                   healthRestorationImage: YonderImages.weaponHealthRestorationIcon,
                   armorPointsRestorationImage: YonderImages.weaponArmorPointsRestorationIcon,
                   remainingUsesImage: YonderImages.weaponRemainingUsesIcon)
        self.previewEffectsDescription = weapon.getEffectPillsDescription()
        self.setEffectsDescription(to: weapon.getEffectsDescription())
        
        weapon.$effectPills.sink(receiveValue: { newValue in
            self.setEffectsDescription(to: weapon.getEffectsDescription())
            self.previewEffectsDescription = weapon.getEffectPillsDescription()
        }).store(in: &self.subscriptions)
        
        weapon.$durabilityPill.sink(receiveValue: { newValue in
            self.setEffectsDescription(to: weapon.getEffectsDescription())
        }).store(in: &self.subscriptions)
    }
    
}
