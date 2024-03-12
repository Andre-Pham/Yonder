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
    public let background: YonderImage
    public let foreground: YonderImage
    public let id: UUID
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
        name: String,
        description: String,
        tags: RegionTagAllocation,
        background: YonderImage,
        foreground: YonderImage,
        bossLocation: BossLocation,
        restorerLocation: RestorerLocation
    ) {
        self.name = name
        self.description = description
        self.background = background
        self.foreground = foreground
        self.id = UUID() // id must be persistent so location contexts can refer to them
        self.tags = tags
        self.bossLocation = bossLocation
        self.restorerLocation = restorerLocation
        
        self.bossLocation.addNextLocations([restorerLocation])
        self.bossLocation.setHexagonCoordinate(5, 33)
        self.restorerLocation.setHexagonCoordinate(5, 35)
        
        for location in self.locations {
            location.setContext(key: self.getRegionKey(), name: self.name, description: self.description, background: self.background, foreground: self.foreground)
        }
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case name
        case description
        case tags
        case backgroundImageName
        case foregroundImageName
        case bossLocation
        case restorerLocation
        case id
    }

    required init(dataObject: DataObject) {
        self.name = dataObject.get(Field.name.rawValue)
        self.description = dataObject.get(Field.description.rawValue)
        self.tags = dataObject.getObject(Field.tags.rawValue, type: RegionTagAllocation.self)
        let backgroundImageName: String = dataObject.get(Field.backgroundImageName.rawValue, onFail: "")
        let foregroundImageName: String = dataObject.get(Field.foregroundImageName.rawValue, onFail: "")
        self.background = backgroundImageName.isEmpty ? YonderImages.missingBackgroundImage : YonderImage(backgroundImageName)
        self.foreground = foregroundImageName.isEmpty ? YonderImages.missingForegroundImage : YonderImage(foregroundImageName)
        assert(!backgroundImageName.isEmpty && !foregroundImageName.isEmpty, "Location image could not be restored")
        self.bossLocation = dataObject.getObject(Field.bossLocation.rawValue, type: BossLocation.self)
        self.restorerLocation = dataObject.getObject(Field.restorerLocation.rawValue, type: RestorerLocation.self)
        self.id = UUID(uuidString: dataObject.get(Field.id.rawValue))!
        
        self.bossLocation.addNextLocations([self.restorerLocation])
        // We don't re-generate location context and such because the serialised locations already have that data
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.tags.rawValue, value: self.tags)
            .add(key: Field.backgroundImageName.rawValue, value: self.background.name)
            .add(key: Field.foregroundImageName.rawValue, value: self.foreground.name)
            .add(key: Field.bossLocation.rawValue, value: self.bossLocation)
            .add(key: Field.restorerLocation.rawValue, value: self.restorerLocation)
            .add(key: Field.id.rawValue, value: self.id.uuidString)
    }
    
    // MARK: - Functions
    
    func getRegionKey() -> String {
        return self.id.uuidString
    }
    
}
