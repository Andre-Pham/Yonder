//
//  ArmorProfile.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class ArmorProfile: AreaThemedProfile {
    
    public let id: Int
    public let armorName: String
    public let armorDescription: String
    public let areaTags: [AreaProfileTag]
    public let armorTag: ArmorProfileTag
    public let armorType: ArmorType
    
    init(id: Int, armorName: String, armorDescription: String, areaTags: [AreaProfileTag], armorTag: ArmorProfileTag, armorType: ArmorType) {
        self.id = id
        self.armorName = armorName
        self.armorDescription = armorDescription
        self.areaTags = areaTags
        self.armorTag = armorTag
        self.armorType = armorType
    }
    
}
