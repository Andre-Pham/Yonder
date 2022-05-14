//
//  YonderImages.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

enum YonderImages {
    
    // MARK: - Placeholders
    
    static let placeholderImage = Image("MajorInn")
    static let missingIcon = Image("MissingIcon")
    
    // MARK: - Tab Bar Icons
    
    static let gameIcon = Image("Sword")
    static let inventoryIcon = Image("Backpack")
    static let mapIcon = Image("Compass")
    static let settingsIcon = Image("Cog")
    
    // MARK: - Stat Icons
    
    static let healthIcon = Image("Heart")
    static let armorPointsIcon = Image("Shield")
    static let goldIcon = Image("Coin")
    static let foeDamageIcon = Image("ClawMarks")
    static let weaponDamageIcon = Image("StrikingBlade")
    static let potionDamageIcon = Image("Explosion")
    static let weaponHealthRestorationIcon = Image("Healing")
    static let potionHealthRestorationIcon = Image("Healing")
    static let weaponRemainingUsesIcon = Image("BrokenSword")
    static let potionRemainingUsesIcon = Image("Potion")
    static let offerIcon = Image("Scroll")
    
    // MARK: - Option Icons
    
    static let weaponOptionIcon = YonderImages.weaponIcon
    static let potionOptionIcon = YonderImages.potionIcon
    static let lootOptionIcon = YonderImages.lootIcon
    
    // MARK: - Item Icons
    
    static let weaponIcon = Image("Axe")
    static let potionIcon = Image("Potion")
    static let armorIcon = Image("Bracer")
    static let lootIcon = Image("Bag")
    
    // MARK: - Location Icons
    
    static let hostileIcon = Image("Skull")
    static let challengeHostileIcon = Image("GlowingSkull")
    static let shopIcon = Image("Flag")
    static let enhancerIcon = Image("Anvil")
    static let restorerIcon = Image("AngelAccessories")
    static let friendlyIcon = Image("Bonfire")
    static let warpIcon = Image("Portal")
    
    // MARK: - Other
    
    static let bracerIcon = Image("Bracer")
    
}
