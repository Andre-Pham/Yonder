//
//  AreaContentContainer.swift
//  yonder
//
//  Created by Andre Pham on 28/12/21.
//

import Foundation
import SwiftUI

class AreaContentContainer {
    
    private(set) var name: String = ""
    private(set) var description: String = ""
    private(set) var image: Image = YonderImages.placeholderImage
    
    func setContent(name: String, description: String, image: Image) {
        self.name = name
        self.description = description
        self.image = image
    }
    
}
