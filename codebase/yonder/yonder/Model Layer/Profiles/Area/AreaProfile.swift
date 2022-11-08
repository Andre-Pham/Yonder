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
    public let areaImage: Image
    public let tags: AreaProfileTagAllocation
    
    init(areaName: String, areaDescription: String, areaImage: Image, tags: AreaProfileTagAllocation) {
        self.areaName = areaName
        self.areaDescription = areaDescription
        self.areaImage = areaImage
        self.tags = tags
    }
    
}
