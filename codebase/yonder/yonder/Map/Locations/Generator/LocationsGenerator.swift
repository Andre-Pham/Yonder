//
//  LocationsGenerator.swift
//  yonder
//
//  Created by Andre Pham on 19/12/21.
//

import Foundation

// TODO: - This should really be organised into classes
// TODO: - Create ArrayFixedSize ("LimitedArray<T>") instead of these dumb limits, and use .isFull() sorta deal

enum LocationsGenerator {
    
    static func generateLocations(arrangement: AreaArrangements) -> [LocationAbstract] {
        var locationIndexPool: [Int] = Array(0..<arrangement.locationCount)
        var nonHostileLocationsCount = arrangement.locationCount/2
        
        var hostileLocationIndices = [Int]()
        
        var challengeHostileLocationIndices = [Int]()
        let challengeHostileLocationsLimit = 3
        
        var shopLocationIndices = [Int]()
        let shopLocationsLimit = 3
        
        var enhancerLocationIndices = [Int]()
        let enhancerLocationsLimit = 2
        
        var restorerLocationIndices = [Int]()
        let restorerLocationsLimit = 2
        
        var friendlyLocationIndices = [Int]()
        let friendlyLocationsLimit = 2
        
        var options: [LocationType] = [.challengeHostile, .shop, .enhancer, .restorer, .friendly]
        
        while nonHostileLocationsCount > 0 {
            guard let locationIndex = locationIndexPool.randomElement() else {
                YonderDebugging.printError(message: "location index pool doesn't have sufficient location indices to match the expected number of non-hostile locations", functionName: #function, className: "\(type(of: self))")
                break
            }
            locationIndexPool.remove(at: locationIndex)
            nonHostileLocationsCount -= 1
            let locationTypeAddedTo = options.randomElement()
            switch locationTypeAddedTo {
            case .challengeHostile:
                challengeHostileLocationIndices.append(locationIndex)
                if challengeHostileLocationIndices.count == challengeHostileLocationsLimit {
                    options = options.filter { $0 != .challengeHostile }
                }
            case .shop:
                shopLocationIndices.append(locationIndex)
                if shopLocationIndices.count == shopLocationsLimit {
                    options = options.filter { $0 != .shop }
                }
            case .enhancer:
                enhancerLocationIndices.append(locationIndex)
                if enhancerLocationIndices.count == enhancerLocationsLimit {
                    options = options.filter { $0 != .enhancer }
                }
            case .restorer:
                restorerLocationIndices.append(locationIndex)
                if restorerLocationIndices.count == restorerLocationsLimit {
                    options = options.filter { $0 != .restorer }
                }
            case .friendly:
                friendlyLocationIndices.append(locationIndex)
                if friendlyLocationIndices.count == friendlyLocationsLimit {
                    options = options.filter { $0 != .friendly }
                }
            default:
                break
            }
        }
        
        hostileLocationIndices.append(contentsOf: locationIndexPool)
        
        var locations = [LocationAbstract](repeating: NoLocation(), count: arrangement.locationCount)
        
        for index in hostileLocationIndices {
            locations[index] = NoLocation() // Grab location from loot pool
        }
        for index in challengeHostileLocationIndices {
            // Repeat for the rest
        }
        
        return locations
    }
    
}
