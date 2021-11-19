//
//  AllArmors.swift
//  yonder
//
//  Created by Andre Pham on 19/11/21.
//

import Foundation

// MARK: - No Armor

let NO_HEAD_ARMOR = NoArmor(type: .head)
let NO_BODY_ARMOR = NoArmor(type: .body)
let NO_LEGS_ARMOR = NoArmor(type: .legs)

// MARK: - Resistance Armor

let TEST_HEAD_ARMOR = ResistanceArmor(type: .head, armorPoints: 200, damageFraction: 0.8)
let TEST_BODY_ARMOR = ResistanceArmor(type: .body, armorPoints: 200, damageFraction: 0.8)
let TEST_LEGS_ARMOR = ResistanceArmor(type: .legs, armorPoints: 200, damageFraction: 0.8)
