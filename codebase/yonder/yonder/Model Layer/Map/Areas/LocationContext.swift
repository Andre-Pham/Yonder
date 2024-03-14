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
    private(set) var tileBackgroundImage: YonderImage = YonderImages.missingTileBackgroundImage
    private(set) var platformImage: YonderImage = YonderImages.missingPlatformImage
    
    init() { }
    
    func setContext(key: String, name: String, description: String, tileBackgroundImage: YonderImage, platformImage: YonderImage) {
        self.key = key
        self.name = name
        self.description = description
        self.tileBackgroundImage = tileBackgroundImage
        self.platformImage = platformImage
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case key
        case name
        case description
        case tileBackgroundImageName
        case platformImageName
    }

    required init(dataObject: DataObject) {
        self.key = dataObject.get(Field.key.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        let tileBackgroundImageName: String = dataObject.get(Field.tileBackgroundImageName.rawValue, onFail: "")
        let platformImageName: String = dataObject.get(Field.platformImageName.rawValue, onFail: "")
        self.tileBackgroundImage = tileBackgroundImageName.isEmpty ? YonderImages.missingTileBackgroundImage : YonderImage(tileBackgroundImageName)
        self.platformImage = platformImageName.isEmpty ? YonderImages.missingPlatformImage : YonderImage(platformImageName)
        assert(!tileBackgroundImageName.isEmpty && !platformImageName.isEmpty, "Location image could not be restored")
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.key.rawValue, value: self.key)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.tileBackgroundImageName.rawValue, value: self.tileBackgroundImage.name)
            .add(key: Field.platformImageName.rawValue, value: self.platformImage.name)
    }
    
}
