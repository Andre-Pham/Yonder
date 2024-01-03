//
//  LocationContext.swift
//  yonder
//
//  Created by Andre Pham on 28/12/21.
//

import Foundation
import SwiftUI

class LocationContext: Storable {
    
    private(set) var key: String = ""
    private(set) var name: String = ""
    private(set) var description: String = ""
    private(set) var imageResource: YonderImage = YonderImages.missingBackgroundImage
    var image: Image {
        return self.imageResource.image
    }
    
    func setContext(key: String, name: String, description: String, imageResource: YonderImage) {
        self.key = key
        self.name = name
        self.description = description
        self.imageResource = imageResource
    }
    
    init() { }
    
    // MARK: - Serialisation

    private enum Field: String {
        case key
        case name
        case description
        case imageName
    }

    required init(dataObject: DataObject) {
        self.key = dataObject.get(Field.key.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.imageResource = YonderImage(dataObject.get(Field.imageName.rawValue))
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.key.rawValue, value: self.key)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.imageName.rawValue, value: self.imageResource.name)
    }
    
}
