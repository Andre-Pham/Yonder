//
//  WeaponProfile.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponProfile {
    
    public let weaponName: String
    public let weaponDescription: String
    public let areaTags: [AreaProfileTag]
    public let weaponTags: WeaponProfileTagAllocation
    
    init(weaponName: String, weaponDescription: String, areaTags: [AreaProfileTag], weaponTags: WeaponProfileTagAllocation) {
        self.weaponName = weaponName
        self.weaponDescription = weaponDescription
        self.areaTags = areaTags
        self.weaponTags = weaponTags
    }
    
}

