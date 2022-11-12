//
//  FriendlyProfile.swift
//  yonder
//
//  Created by Andre Pham on 12/11/2022.
//

import Foundation

class FriendlyProfile {
    
    // MARK: TODO
    // I will have to make Friendly.newX instances like I do with foes
    // There will be a lot
    // I'll use the same approach as enhance options, but i'll just shuffle and return the first
    // friendly instead of x number of enhance options
    
    public let friendlyName: String
    public let friendlyDescription: String
    public let areaTags: [AreaProfileTag]
    
    init(friendlyName: String, friendlyDescription: String, areaTags: [AreaProfileTag]) {
        self.friendlyName = friendlyName
        self.friendlyDescription = friendlyDescription
        self.areaTags = areaTags
    }
    
}
