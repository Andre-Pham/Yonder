//
//  BossArea.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

class BossArea: Region, Storable {
    
    public let name: String
    public let description: String
    public let tileBackgroundImage: YonderImage
    public let platformImage: YonderImage
    public let id: UUID
    public let regionKey: UUID
    public let tags: RegionTagAllocation
    public let bossLocation: BossLocation
    public let restorerLocation: RestorerLocation
    public var locations: [Location] {
        return [self.bossLocation, self.restorerLocation]
    }
    public var rootLocations: [Location] {
        return [self.bossLocation]
    }
    public var tipLocations: [Location] {
        return [self.restorerLocation]
    }
    
    init(
        regionKey: UUID,
        name: String,
        description: String,
        tags: RegionTagAllocation,
        tileBackgroundImage: YonderImage,
        platformImage: YonderImage,
        bossLocation: BossLocation,
        restorerLocation: RestorerLocation
    ) {
        // Unlike other regions which refer to their regular id as their region key, BossAreas have their region key passed to them
        // This lets them copy their region from the preceding tavern area, meaning they can share factories
        self.regionKey = regionKey
        self.name = name
        self.description = description
        self.tileBackgroundImage = tileBackgroundImage
        self.platformImage = platformImage
        self.id = UUID() // id must be persistent so location contexts can refer to them
        self.tags = tags
        self.bossLocation = bossLocation
        self.restorerLocation = restorerLocation
        
        self.bossLocation.addNextLocations([restorerLocation])
        self.bossLocation.setHexagonCoordinate(5, 33)
        self.restorerLocation.setHexagonCoordinate(5, 35)
        
        for location in self.locations {
            location.setContext(
                // We want to match the boss area to where the player previously was
                // So we pass the provided information in as a placeholder/default
                // But when we get there, we reload the context to match where the player previously was
                // If desired, we can flip reloadOnDemand to false, and the boss area will use whatever region it was provided
                reloadOnDemand: true,
                key: self.getRegionKey(),
                name: self.name,
                description: self.description,
                tileBackgroundImage: self.tileBackgroundImage,
                platformImage: self.platformImage
            )
        }
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case name
        case description
        case tags
        case tileBackgroundImageName
        case platformImageName
        case bossLocation
        case restorerLocation
        case id
        case regionKey
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.tags = dataObject.getObject(Field.tags.rawValue, type: RegionTagAllocation.self)
        let tileBackgroundImageName: String = dataObject.get(Field.tileBackgroundImageName.rawValue, onFail: "")
        let platformImageName: String = dataObject.get(Field.platformImageName.rawValue, onFail: "")
        self.tileBackgroundImage = tileBackgroundImageName.isEmpty ? YonderImages.missingTileBackgroundImage : YonderImage(tileBackgroundImageName)
        self.platformImage = platformImageName.isEmpty ? YonderImages.missingPlatformImage : YonderImage(platformImageName)
        assert(!tileBackgroundImageName.isEmpty && !platformImageName.isEmpty, "Location image could not be restored")
        self.bossLocation = dataObject.getObject(Field.bossLocation.rawValue, type: BossLocation.self)
        self.restorerLocation = dataObject.getObject(Field.restorerLocation.rawValue, type: RestorerLocation.self)
        self.id = UUID(uuidString: dataObject.get(Field.id.rawValue))!
        self.regionKey = UUID(uuidString: dataObject.get(Field.regionKey.rawValue))!
        
        self.bossLocation.addNextLocations([self.restorerLocation])
        // We don't re-generate location context and such because the serialised locations already have that data
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.tags.rawValue, value: self.tags)
            .add(key: Field.tileBackgroundImageName.rawValue, value: self.tileBackgroundImage.name)
            .add(key: Field.platformImageName.rawValue, value: self.platformImage.name)
            .add(key: Field.bossLocation.rawValue, value: self.bossLocation)
            .add(key: Field.restorerLocation.rawValue, value: self.restorerLocation)
            .add(key: Field.id.rawValue, value: self.id.uuidString)
            .add(key: Field.regionKey.rawValue, value: self.regionKey.uuidString)
    }
    
    // MARK: - Functions
    
    func getRegionKey() -> String {
        return self.regionKey.uuidString
    }
    
}
