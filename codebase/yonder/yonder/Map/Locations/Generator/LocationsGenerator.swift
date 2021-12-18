//
//  LocationsGenerator.swift
//  yonder
//
//  Created by Andre Pham on 19/12/21.
//

import Foundation

enum LocationsGenerator {
    
    static func generateLocations(arrangement: AreaArrangements) -> [LocationAbstract] {
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
                // Grab locations from loot pools here
                // Loot pool function should have level, location type, as parameters
                locations[locationIndex] = NoLocation()
            }
        }
        
        return locations
    }
    
}
