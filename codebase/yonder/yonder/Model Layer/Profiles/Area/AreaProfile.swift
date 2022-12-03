//
//  AreaProfile.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation
import SwiftUI

class AreaProfile {
    
    public let areaName: String
    public let areaDescription: String
    public let areaImageResource: ImageResource
    public let tags: AreaProfileTagAllocation
    
    init(areaName: String, areaDescription: String, areaImage: ImageResource, tags: AreaProfileTagAllocation) {
        self.areaName = areaName
        self.areaDescription = areaDescription
        self.areaImageResource = areaImage
        self.tags = tags
    }
    
}
