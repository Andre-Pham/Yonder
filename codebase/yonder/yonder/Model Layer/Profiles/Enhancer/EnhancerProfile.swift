//
//  EnhancerProfile.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class EnhancerProfile: AreaThemedProfile {
    
    public let id: String
    public let enhancerName: String
    public let enhancerDescription: String
    public let regionTags: [RegionProfileTag]
    
    init(id: String, enhancerName: String, enhancerDescription: String, regionTags: [RegionProfileTag]) {
        self.id = id
        self.enhancerName = enhancerName
        self.enhancerDescription = enhancerDescription
        self.regionTags = regionTags
    }
    
}
