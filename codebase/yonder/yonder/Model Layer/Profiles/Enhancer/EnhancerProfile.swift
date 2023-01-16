//
//  EnhancerProfile.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class EnhancerProfile: AreaThemedProfile {
    
    public let id: Int
    public let enhancerName: String
    public let enhancerDescription: String
    public let areaTags: [AreaProfileTag]
    
    init(id: Int, enhancerName: String, enhancerDescription: String, areaTags: [AreaProfileTag]) {
        self.id = id
        self.enhancerName = enhancerName
        self.enhancerDescription = enhancerDescription
        self.areaTags = areaTags
    }
    
}
