//
//  WeaponProfile.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponProfile: AreaThemedProfile {
    
    public let id: String
    public let weaponName: String
    public let regionTags: [RegionProfileTag]
    public let weaponTags: [WeaponProfileTag]
    
    init(id: String, weaponName: String, regionTags: [RegionProfileTag], weaponTags: [WeaponProfileTag]) {
        self.id = id
        self.weaponName = weaponName
        self.regionTags = regionTags
        self.weaponTags = weaponTags
    }
    
}

