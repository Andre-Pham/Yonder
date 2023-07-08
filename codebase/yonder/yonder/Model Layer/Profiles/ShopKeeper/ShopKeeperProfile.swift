//
//  ShopKeeperProfile.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ShopKeeperProfile: AreaThemedProfile {
    
    public let id: String
    public let shopKeeperName: String
    public let shopKeeperDescription: String
    public let regionTags: [RegionProfileTag]
    
    init(id: String, shopKeeperName: String, shopKeeperDescription: String, regionTags: [RegionProfileTag]) {
        self.id = id
        self.shopKeeperName = shopKeeperName
        self.shopKeeperDescription = shopKeeperDescription
        self.regionTags = regionTags
    }
    
}
