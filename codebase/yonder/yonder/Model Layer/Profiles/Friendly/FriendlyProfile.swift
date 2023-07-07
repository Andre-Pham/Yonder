//
//  FriendlyProfile.swift
//  yonder
//
//  Created by Andre Pham on 12/11/2022.
//

import Foundation

class FriendlyProfile: AreaThemedProfile {
    
    public let id: String
    public let friendlyName: String
    public let friendlyDescription: String
    public let regionTags: [RegionProfileTag]
    public let friendlyTags: [FriendlyProfileTag]
    
    init(id: String, friendlyName: String, friendlyDescription: String, regionTags: [RegionProfileTag], friendlyTags: [FriendlyProfileTag]) {
        self.id = id
        self.friendlyName = friendlyName
        self.friendlyDescription = friendlyDescription
        self.regionTags = regionTags
        self.friendlyTags = friendlyTags
    }
    
}
