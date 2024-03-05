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
        super.init(
            weapon,
            remainingUsesDescription: Strings("stat.weapon.remainingUses").local,
            inspectTag: Strings("inspect.tag.weapon").local,
            damageImage: YonderIcons.weaponDamageIcon,
            restorationImage: YonderIcons.weaponRestorationIcon,
            healthRestorationImage: YonderIcons.weaponHealthRestorationIcon,
            armorPointsRestorationImage: YonderIcons.weaponArmorPointsRestorationIcon,
            remainingUsesImage: YonderIcons.weaponRemainingUsesIcon
        )
        self.previewEffectsDescription = weapon.getPreviewEffectsDescription()
        self.setEffectsDescription(to: weapon.getEffectsDescription())
        
        weapon.$effectPills.sink(receiveValue: { newValue in
            self.setEffectsDescription(to: weapon.getEffectsDescription())
            self.previewEffectsDescription = weapon.getPreviewEffectsDescription()
        }).store(in: &self.subscriptions)
        
        weapon.$buffPills.sink(receiveValue: { newValue in
            self.setEffectsDescription(to: weapon.getEffectsDescription())
            self.previewEffectsDescription = weapon.getPreviewEffectsDescription()
        }).store(in: &self.subscriptions)
        
        weapon.$durabilityPill.sink(receiveValue: { newValue in
            self.setEffectsDescription(to: weapon.getEffectsDescription())
        }).store(in: &self.subscriptions)
    }
    
}
