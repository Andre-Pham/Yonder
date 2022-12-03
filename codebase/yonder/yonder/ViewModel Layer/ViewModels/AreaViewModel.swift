//
//  AreaViewModel.swift
//  yonder
//
//  Created by Andre Pham on 14/5/2022.
//

import Foundation
import SwiftUI

class AreaViewModel: ObservableObject {
    
    public let name: String
    public let description: String
    public let image: Image
    
    init(locationContext: LocationContext) {
        self.name = locationContext.name
        self.description = locationContext.description
        self.image = locationContext.image
    }
    
}
