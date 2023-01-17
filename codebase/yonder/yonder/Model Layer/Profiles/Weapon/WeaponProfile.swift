//
//  WeaponProfile.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponProfile: AreaThemedProfile {
    
    public let id: Int
    public let weaponName: String
    public let weaponDescription: String
    public let regionTags: [RegionProfileTag]
    public let weaponTags: [WeaponProfileTag]
    
    init(id: Int, weaponName: String, weaponDescription: String, regionTags: [RegionProfileTag], weaponTags: [WeaponProfileTag]) {
        self.id = id
        self.weaponName = weaponName
        self.weaponDescription = weaponDescription
        self.regionTags = regionTags
        self.weaponTags = weaponTags
    }
    
}

