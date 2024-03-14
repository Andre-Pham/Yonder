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
    public let regionTileBackgroundImage: YonderImage
    public let regionPlatformImage: YonderImage
    public let tags: RegionTagAllocation
    public let assignment: RegionProfileAssignment
    
    init(
        regionName: String,
        regionDescription: String,
        regionTileBackgroundImage: YonderImage,
        regionPlatformImage: YonderImage,
        tags: RegionTagAllocation,
        assignment: RegionProfileAssignment
    ) {
        self.regionName = regionName
        self.regionDescription = regionDescription
        self.regionTileBackgroundImage = regionTileBackgroundImage
        self.regionPlatformImage = regionPlatformImage
        self.tags = tags
        self.assignment = assignment
    }
    
}
