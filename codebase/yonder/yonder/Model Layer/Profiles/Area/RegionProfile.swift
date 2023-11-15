//
//  RegionProfile.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation
import SwiftUI

class RegionProfile {
    
    public let regionName: String
    public let regionDescription: String
    public let regionImageResource: YonderImage
    public let tags: RegionTagAllocation
    
    init(regionName: String, regionDescription: String, regionImage: YonderImage, tags: RegionTagAllocation) {
        self.regionName = regionName
        self.regionDescription = regionDescription
        self.regionImageResource = regionImage
        self.tags = tags
    }
    
}
