//
//  ImageResource.swift
//  yonder
//
//  Created by Andre Pham on 3/12/2022.
//

import Foundation
import SwiftUI

class ImageResource {
    
    let name: String
    var image: Image {
        Image(self.name)
    }
    
    init(_ name: String) {
        assert(UIImage(named: name) != nil, "Resource name has no matching resource")
        self.name = name
    }
    
}
