//
//  FoeProfile.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class FoeProfile {
    
    public let foeName: String
    public let foeDescription: String
    public let foeTags: [FoeProfileTag]
    public let areaTags: [AreaProfileTag]
    
    init(foeName: String, foeDescription: String, foeTags: [FoeProfileTag], areaTags: [AreaProfileTag]) {
        self.foeName = foeName
        self.foeDescription = foeDescription
        self.foeTags = foeTags
        self.areaTags = areaTags
    }
    
}