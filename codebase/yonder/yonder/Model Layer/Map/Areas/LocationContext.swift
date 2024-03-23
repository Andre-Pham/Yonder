//
//  LocationContext.swift
//  yonder
//
//  Created by Andre Pham on 28/12/21.
//

import Foundation
import SwiftUI

class LocationContext: Storable {
    
    private var loadOnDemand = true
    private(set) var key: String = ""
    private(set) var name: String = ""
    private(set) var description: String = ""
    private(set) var tileBackgroundImage: YonderImage = YonderImages.missingTileBackgroundImage
    private(set) var platformImage: YonderImage = YonderImages.missingPlatformImage
    public var shouldBeLoaded: Bool {
        return self.key.isEmpty || self.loadOnDemand
    }
    
    init() { }
    
    func setContext(reloadOnDemand: Bool = false, key: String, name: String, description: String, tileBackgroundImage: YonderImage, platformImage: YonderImage) {
        self.loadOnDemand = reloadOnDemand
        self.key = key
        self.name = name
        self.description = description
        self.tileBackgroundImage = tileBackgroundImage
        self.platformImage = platformImage
    }
    
    /// Match this context to another location's context - to be used for on-demand loading when the context of an area is based on where the player previously was located.
    /// - Parameters:
    ///   - location: The location to match this context to
    func matchLocationContext(_ location: Location) {
        self.loadOnDemand = false // Loaded on-demand, there's no chance we need to mark this as needing to be loaded-on-demand again
        self.key = location.context.key
        self.name = location.context.name
        self.description = location.context.description
        self.platformImage = location.context.platformImage
        // Tile background image isn't changed - the entire map is loaded from the start, so this can't be loaded on-demand
    }
    
    /// Set just the tile background image - used when you're relying on on-demand loading for the rest of the context
    func setTileBackgroundImage(tileBackground: YonderImage) {
        self.tileBackgroundImage = tileBackground
        assert(self.loadOnDemand, "Shouldn't be setting just the tile background image if you're not loading on demand")
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case loadOnDemand
        case key
        case name
        case description
        case tileBackgroundImageName
        case platformImageName
    }

    required init(dataObject: DataObject) {
        self.loadOnDemand = dataObject.get(Field.loadOnDemand.rawValue, onFail: true)
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
            .add(key: Field.loadOnDemand.rawValue, value: self.loadOnDemand)
            .add(key: Field.key.rawValue, value: self.key)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.tileBackgroundImageName.rawValue, value: self.tileBackgroundImage.name)
            .add(key: Field.platformImageName.rawValue, value: self.platformImage.name)
    }
    
}
