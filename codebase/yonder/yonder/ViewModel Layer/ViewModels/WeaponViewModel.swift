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
    
    init(_ weapon: Weapon) {
        super.init(weapon,
                   remainingUsesDescription: Strings.Stat.Weapon.RemainingUses.local,
                   damageImage: YonderImages.weaponDamageIcon,
                   healthRestorationImage: YonderImages.weaponHealthRestorationIcon,
                   remainingUsesImage: YonderImages.weaponRemainingUsesIcon)
    }
    
}
