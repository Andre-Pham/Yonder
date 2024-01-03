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
    public let regionBackground: YonderImage
    public let regionForeground: YonderImage
    public let tags: RegionTagAllocation
    public let assignment: RegionProfileAssignment
    
    init(
        regionName: String,
        regionDescription: String,
        regionBackground: YonderImage,
        regionForeground: YonderImage,
        tags: RegionTagAllocation,
        assignment: RegionProfileAssignment
    ) {
        self.regionName = regionName
        self.regionDescription = regionDescription
        self.regionBackground = regionBackground
        self.regionForeground = regionForeground
        self.tags = tags
        self.assignment = assignment
    }
    
}
