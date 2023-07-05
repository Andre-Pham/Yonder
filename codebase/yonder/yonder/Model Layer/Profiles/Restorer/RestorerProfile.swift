//
//  RestorerProfile.swift
//  yonder
//
//  Created by Andre Pham on 11/11/2022.
//

import Foundation

class RestorerProfile: AreaThemedProfile {
    
    public let id: String
    public let restorerName: String
    public let restorerDescription: String
    public let regionTags: [RegionProfileTag]
    public let restoreOptions: [Restorer.RestoreOption]
    
    init(id: String, restorerName: String, restorerDescription: String, regionTags: [RegionProfileTag], restoreOptions: [Restorer.RestoreOption]) {
        self.id = id
        self.restorerName = restorerName
        self.restorerDescription = restorerDescription
        self.regionTags = regionTags
        self.restoreOptions = restoreOptions
    }
    
    func matchesRestoreOptions(_ otherRestoreOptions: [Restorer.RestoreOption]) -> Bool {
        guard self.restoreOptions.count == otherRestoreOptions.count else {
            return false
        }
        var allMatch = true
        for option in self.restoreOptions {
            if !otherRestoreOptions.contains(option) {
                allMatch = false
            }
        }
        return allMatch
    }
    
    func containsRestoreOptions(_ otherRestoreOptions: [Restorer.RestoreOption]) -> Bool {
        var allMatch = true
        for option in otherRestoreOptions {
            if !self.restoreOptions.contains(option) {
                allMatch = false
            }
        }
        return allMatch
    }
    
}
