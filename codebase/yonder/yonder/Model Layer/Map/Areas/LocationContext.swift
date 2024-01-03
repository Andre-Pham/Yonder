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
    private(set) var background: YonderImage = YonderImages.missingBackgroundImage
    private(set) var foreground: YonderImage = YonderImages.missingForegroundImage
    
    func setContext(key: String, name: String, description: String, background: YonderImage, foreground: YonderImage) {
        self.key = key
        self.name = name
        self.description = description
        self.background = background
        self.foreground = foreground
    }
    
    init() { }
    
    // MARK: - Serialisation

    private enum Field: String {
        case key
        case name
        case description
        case backgroundImageName
        case foregroundImageName
    }

    required init(dataObject: DataObject) {
        self.key = dataObject.get(Field.key.rawValue)
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        let backgroundImageName: String = dataObject.get(Field.backgroundImageName.rawValue, onFail: "")
        let foregroundImageName: String = dataObject.get(Field.foregroundImageName.rawValue, onFail: "")
        self.background = backgroundImageName.isEmpty ? YonderImages.missingBackgroundImage : YonderImage(backgroundImageName)
        self.foreground = foregroundImageName.isEmpty ? YonderImages.missingForegroundImage : YonderImage(foregroundImageName)
        assert(!backgroundImageName.isEmpty && !foregroundImageName.isEmpty, "Location image could not be restored")
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.key.rawValue, value: self.key)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.backgroundImageName.rawValue, value: self.background.name)
            .add(key: Field.foregroundImageName.rawValue, value: self.foreground.name)
    }
    
}
