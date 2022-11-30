//
//  WeaponProfile.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponProfile: AreaThemedProfile {
    
    public let weaponName: String
    public let weaponDescription: String
    public let areaTags: [AreaProfileTag]
    public let weaponTags: [WeaponProfileTag]
    
    init(weaponName: String, weaponDescription: String, areaTags: [AreaProfileTag], weaponTags: [WeaponProfileTag]) {
        self.weaponName = weaponName
        self.weaponDescription = weaponDescription
        self.areaTags = areaTags
        self.weaponTags = weaponTags
    }
    
}

