//
//  WeaponFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let weaponProfileBucket: WeaponProfileBucket
    private var weaponSupply = [Weapon]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: WeaponProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.weaponProfileBucket = profileBucket
    }
    
    private func buildWeapons(stage: Int, tags: AreaProfileTagAllocation) {
        var weapons = [Weapon]()
        
        weapons.populate(count: 20) {
            Weapons.damageWeapon(profile: self.weaponProfileBucket.grabProfile(areaTag: tags.getTag(), weaponTags: [.damage]), stage: stage)
        }
        // repeat for all types of weapons
        
        weapons.shuffle()
        self.weaponSupply.append(contentsOf: weapons)
    }
    
    func deliver() -> Weapon {
        guard !self.weaponSupply.isEmpty else {
            self.buildWeapons(stage: self.stage, tags: self.areaTags)
        }
        return self.weaponSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Weapon] {
        guard self.weaponSupply.count >= count else {
            self.buildWeapons(stage: self.stage, tags: self.areaTags)
        }
        return self.weaponSupply.dropLast(count)
    }
    
}
