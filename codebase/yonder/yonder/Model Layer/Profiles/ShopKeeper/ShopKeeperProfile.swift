//
//  ShopKeeperProfile.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class ShopKeeperProfile: AreaThemedProfile {
    
    public let shopKeeperName: String
    public let shopKeeperDescription: String
    public let areaTags: [AreaProfileTag]
    
    init(shopKeeperName: String, shopKeeperDescription: String, areaTags: [AreaProfileTag]) {
        self.shopKeeperName = shopKeeperName
        self.shopKeeperDescription = shopKeeperDescription
        self.areaTags = areaTags
    }
    
}
