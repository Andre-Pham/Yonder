//
//  RestorerProfile.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class RestorerProfile {
    
    public let restorerName: String
    public let restorerDescription: String
    public let areaTags: [AreaProfileTag]
    public let restoreOptions: RestoreOptionsAllocation
    
    init(restorerName: String, restorerDescription: String, areaTags: [AreaProfileTag], restoreOptions: [Restorer.RestoreOption]) {
        self.restorerName = restorerName
        self.restorerDescription = restorerDescription
        self.areaTags = areaTags
        self.restoreOptions = RestoreOptionsAllocation(options: restoreOptions)
    }
    
}
