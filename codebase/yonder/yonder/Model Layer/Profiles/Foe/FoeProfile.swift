//
//  FoeProfile.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class FoeProfile: AreaThemedProfile {
    
    public let id: String
    public let foeName: String
    public let foeDescription: String
    public let foeTags: [FoeProfileTag]
    public let regionTags: [RegionProfileTag]
    
    init(id: String, foeName: String, foeDescription: String, foeTags: [FoeProfileTag], regionTags: [RegionProfileTag]) {
        self.id = id
        self.foeName = foeName
        self.foeDescription = foeDescription
        self.foeTags = foeTags
        self.regionTags = regionTags
    }
    
}
