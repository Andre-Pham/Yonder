//
//  TavernArea.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

class TavernArea: Region, Storable {
    
    public let name: String
    public let description: String
    public let tileBackgroundImage: YonderImage
    public let platformImage: YonderImage
    public let id: UUID
    private(set) var rootLocations = [Location]()
    private(set) var tipLocations = [Location]()
    public let arrangement: TavernAreaArrangements
    public let locations: [Location]
    public let tags: RegionTagAllocation
    
    init(
        name: String,
        description: String,
        tags: RegionTagAllocation,
        tileBackgroundImage: YonderImage,
        platformImage: YonderImage,
        _ locations: Location...
    ) {
        self.name = name
        self.description = description
        self.tags = tags
        self.tileBackgroundImage = tileBackgroundImage
        self.platformImage = platformImage
        self.id = UUID() // id must be persistent so location contexts can refer to them
        switch locations.count {
        case 3:
            self.arrangement = .S
        case 4:
            self.arrangement = .M
        case 5:
            self.arrangement = .L
        case 6:
            self.arrangement = .XL
        default:
            fatalError("Number of locations provided to tavern area don't correspond to a tavern area arrangement")
        }
        self.locations = locations
        self.addRootAndTipLocations()
        self.generateAreaArrangement()
        for location in self.locations {
            location.setContext(key: self.getRegionKey(), name: self.name, description: self.description, tileBackgroundImage: self.tileBackgroundImage, platformImage: self.platformImage)
        }
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case name
        case description
        case tags
        case tileBackgroundImageName
        case platformImageName
        case arrangement
        case locations
        case id
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
        self.arrangement = TavernAreaArrangements(rawValue: dataObject.get(Field.arrangement.rawValue)) ?? .S
        self.locations = dataObject.getObjectArray(Field.locations.rawValue, type: LocationAbstract.self) as! [any Location]
        self.id = UUID(uuidString: dataObject.get(Field.id.rawValue))!
        
        self.addRootAndTipLocations()
        // We don't re-generate area arrangement because the serialised locations already have that data
        // We also don't reassign location context for the same reason
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.name.rawValue, value: self.name)
            .add(key: Field.description.rawValue, value: self.description)
            .add(key: Field.tags.rawValue, value: self.tags)
            .add(key: Field.tileBackgroundImageName.rawValue, value: self.tileBackgroundImage.name)
            .add(key: Field.platformImageName.rawValue, value: self.platformImage.name)
            .add(key: Field.arrangement.rawValue, value: self.arrangement.rawValue)
            .add(key: Field.locations.rawValue, value: self.locations as [LocationAbstract])
            .add(key: Field.id.rawValue, value: self.id.uuidString)
    }

    // MARK: - Functions
    
    func getRegionKey() -> String {
        return self.id.uuidString
    }
    
    func addRootLocations(_ locations: [Location]) {
        self.rootLocations.append(contentsOf: locations)
    }
    
    func addRootLocations(_ locationIndices: Int...) {
        let locations = locationIndices.map { self.locations[$0] }
        self.addRootLocations(locations)
    }
    
    func addTipLocations(_ locations: [Location]) {
        self.tipLocations.append(contentsOf: locations)
    }
    
    func addTipLocations(_ locationIndices: Int...) {
        let locations = locationIndices.map { self.locations[$0] }
        self.addTipLocations(locations)
    }
    
    func addNextLocations(from location: Location, to nextLocations: [Location]) {
        location.addNextLocations(nextLocations)
    }
    
    func addNextLocations(from locationIndex: Int, to nextLocationIndices: Int...) {
        let location = self.locations[locationIndex]
        let nextLocations = nextLocationIndices.map { self.locations[$0] }
        self.addNextLocations(from: location, to: nextLocations)
    }
    
    func createUndirectedEdge(between location: Location, and otherLocation: Location) {
        location.addNextLocations([otherLocation])
        otherLocation.addNextLocations([location])
    }
    
    func createUndirectedEdge(between locationIndex: Int, and otherLocationIndex: Int) {
        let location = self.locations[locationIndex]
        let otherLocation = self.locations[otherLocationIndex]
        self.createUndirectedEdge(between: location, and: otherLocation)
    }

}
