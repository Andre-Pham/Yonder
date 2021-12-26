//
//  Generators.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

enum Generators {
    
    static func generateTerritoriesIntoMap(mapPool: MapPool) -> Map {
        let areaArrangementPool = AreaArrangementPool()
        var territories = [Territory]()
        for territoryStage in 0..<mapPool.territoryPoolsInStageOrder.count {
            territories.append(generateSegmentsIntoTerritory(arrangementPool: areaArrangementPool, mapPool: mapPool, stage: territoryStage))
        }
        
        // TODO: - Add boss stuff
        return Map(territoriesInOrder: territories, bossAreasInOrder: [])
    }
    
    static func generateSegmentsIntoTerritory(arrangementPool: AreaArrangementPool, mapPool: MapPool, stage: Int) -> Territory {
        let territoryPool = mapPool.grabTerritoryPool(stage: stage)
        let segment = Generators.generateAreasIntoSegment(arrangementPool: arrangementPool, territoryPool: territoryPool!)
        let tavernArea = territoryPool?.grabTavernArea()
        
        return Territory(segment: segment, followingTavernArea: tavernArea!)
    }
    
    static func generateAreasIntoSegment(arrangementPool: AreaArrangementPool, territoryPool: TerritoryPool) -> Segment {
        let leftArea = Generators.generateLocationsIntoArea(arrangement: arrangementPool.grabAreaArrangement(), areaPool: territoryPool.grabAreaPool()!)
        let rightArea = Generators.generateLocationsIntoArea(arrangement: arrangementPool.grabAreaArrangement(), areaPool: territoryPool.grabAreaPool()!)
        
        return Segment(leftArea: leftArea, rightArea: rightArea)
    }
    
    static func generateLocationsIntoArea(arrangement: AreaArrangements, areaPool: AreaPool) -> Area {
        var locationIndexPool: [Int] = Array(0..<arrangement.locationCount)
        var nonHostileLocationsCount = arrangement.locationCount/2
        
        let hostileLocationIndices = LocationIndexContainer(sizeLimit: locationIndexPool.count-nonHostileLocationsCount, type: .hostile)
        let challengeHostileLocationIndices = LocationIndexContainer(sizeLimit: 3, type: .challengeHostile)
        let shopLocationIndices = LocationIndexContainer(sizeLimit: 3, type: .shop)
        let enhancerLocationIndices = LocationIndexContainer(sizeLimit: 2, type: .enhancer)
        let restorerLocationIndices = LocationIndexContainer(sizeLimit: 2, type: .restorer)
        let friendlyLocationIndices = LocationIndexContainer(sizeLimit: 2, type: .friendly)
        
        let allOptions: [LocationIndexContainer] = [
            hostileLocationIndices,
            challengeHostileLocationIndices,
            shopLocationIndices,
            enhancerLocationIndices,
            restorerLocationIndices,
            friendlyLocationIndices
        ]
        
        var nonHostileOptions: [LocationIndexContainer] = [
            challengeHostileLocationIndices,
            shopLocationIndices,
            enhancerLocationIndices,
            restorerLocationIndices,
            friendlyLocationIndices
        ]
        
        while nonHostileLocationsCount > 0 {
            guard let locationIndex = locationIndexPool.randomElement() else {
                YonderDebugging.printError(message: "Location index pool doesn't have sufficient location indices to match the expected number of non-hostile locations", functionName: #function, className: "\(type(of: self))")
                break
            }
            locationIndexPool.remove(at: locationIndexPool.firstIndex(of: locationIndex)!)
            nonHostileLocationsCount -= 1
            
            guard let locationIndexContainer = nonHostileOptions.randomElement() else {
                YonderDebugging.printError(message: "All non-hostile location options were filled, which shouldn't be possible", functionName: #function, className: "\(type(of: self))")
                break
            }
            locationIndexContainer.addIndex(locationIndex)
            if locationIndexContainer.isFull {
                nonHostileOptions = nonHostileOptions.filter { $0.type != locationIndexContainer.type }
            }
        }
        
        for index in locationIndexPool {
            hostileLocationIndices.addIndex(index)
        }
        
        var locations = [LocationAbstract](repeating: NoLocation(), count: arrangement.locationCount)
        
        for locationIndexContainer in allOptions {
            for locationIndex in locationIndexContainer.indices {
                locations[locationIndex] = areaPool.grabLocation(locationType: locationIndexContainer.type)
            }
        }
        
        return Area(arrangement: arrangement, locations: locations)
    }
    
}

class LocationIndexContainer {
    
    private(set) var indices = [Int]()
    public let type: LocationType
    public let sizeLimit: Int
    public var isFull: Bool {
        return indices.count == sizeLimit
    }
    
    init(sizeLimit: Int, type: LocationType) {
        self.sizeLimit = sizeLimit
        self.type = type
    }
    
    func addIndex(_ index: Int) {
        guard !self.isFull else {
            return
        }
        self.indices.append(index)
    }
    
}
