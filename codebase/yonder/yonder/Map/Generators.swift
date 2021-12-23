//
//  Generators.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

enum Generator {
    
    static func generateMap() {
        
        let bossesCount = 4 // Not including final boss
        let territoriesCount = bossesCount*2 + 2 // Extra 2 for the final boss
        
        let areaArrangementPool = AreaArrangementPool()
        let mapPool = MapPool(territoryPools: <#T##[TerritoryPool]#>) // Defined as part of content
        
        //let map = Map(territoriesInOrder: <#T##[Territory]#>)
        let territories = [Territory]()
        
        for territoryIndex in 0..<territoriesCount {
            let territoryPool = mapPool.grabTerritory()
            let leftAreaPool = territoryPool?.grabAreaPool()
            let rightAreaPool = territoryPool?.grabAreaPool()
            let leftLocations = 
            
            let leftArea = Area(arrangement: areaArrangementPool.grabAreaArrangement(), locations: <#T##[LocationAbstract]#>)
            let rightArea = Area(arrangement: areaArrangementPool.grabAreaArrangement(), locations: <#T##[LocationAbstract]#>)
            let segment = Segment(leftArea: <#T##Area#>, rightArea: <#T##Area#>)
            let territory = Territory(segment: <#T##Segment#>, followingTavernArea: <#T##TavernArea#>)
        }
        
    }
    
    static func generateArea() {
        
    }
    
    static func generateLocationsIntoArea(arrangement: AreaArrangements, areaLocationsPool: AreaLocationsPool) -> Area {
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
            locationIndexPool.remove(at: locationIndex)
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
                locations[locationIndex] = areaLocationsPool.grabLocation(locationType: locationIndexContainer.type)
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
