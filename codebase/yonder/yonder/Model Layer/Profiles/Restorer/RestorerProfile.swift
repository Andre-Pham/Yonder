//
//  RestorerProfile.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class RestorerProfile: AreaThemedProfile {
    
    public let id: Int
    public let restorerName: String
    public let restorerDescription: String
    public let regionTags: [RegionProfileTag]
    public let restoreOptions: RestoreOptionsAllocation
    
    init(id: Int, restorerName: String, restorerDescription: String, regionTags: [RegionProfileTag], restoreOptions: [Restorer.RestoreOption]) {
        self.id = id
        self.restorerName = restorerName
        self.restorerDescription = restorerDescription
        self.regionTags = regionTags
        self.restoreOptions = RestoreOptionsAllocation(options: restoreOptions)
    }
    
}
