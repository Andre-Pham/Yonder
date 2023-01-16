//
//  FriendlyProfile.swift
//  yonder
//
//  Created by Andre Pham on 12/11/2022.
//

import Foundation

class FriendlyProfile: AreaThemedProfile {
    
    public let id: Int
    public let friendlyName: String
    public let friendlyDescription: String
    public let areaTags: [AreaProfileTag]
    public let friendlyTag: FriendlyProfileTag
    
    init(id: Int, friendlyName: String, friendlyDescription: String, areaTags: [AreaProfileTag], friendlyTag: FriendlyProfileTag) {
        self.id = id
        self.friendlyName = friendlyName
        self.friendlyDescription = friendlyDescription
        self.areaTags = areaTags
        self.friendlyTag = friendlyTag
    }
    
}
