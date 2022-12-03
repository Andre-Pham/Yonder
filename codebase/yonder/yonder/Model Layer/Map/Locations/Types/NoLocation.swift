//
//  NoLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class NoLocation: Location {
    
    public let type: LocationType = .none
    
    override init() {
        super.init()
        self.setContext(name: "placeholderName", description: "placeholderDescription", imageName: YonderImages.placeholderImage.name)
    }
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
}
