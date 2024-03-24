//
//  StartingLocation.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2024.
//

import Foundation

class StartingLocation: Location {
    
    public let type: LocationType = .starting
    
    override init() {
        super.init()
        // Region profile bucket doesn't need to persist - we're just copying a profile from stage 0
        let profile = RegionProfileBucket().grabProfile(stage: 0, regionAssignment: .area)
        // Starting location has no content - no key required
        self.setContext(
            key: "",
            name: profile.regionName,
            description: profile.regionDescription,
            tileBackgroundImage: profile.regionTileBackgroundImage,
            platformImage: profile.regionPlatformImage
        )
        // Starting location is always in the centre
        self.setHexagonCoordinate(5, 1)
    }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        // No content to initialise
    }
    
}

