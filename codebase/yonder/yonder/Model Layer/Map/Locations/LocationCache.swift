//
//  LocationCache.swift
//  yonder
//
//  Created by Andre Pham on 4/12/2022.
//

import Foundation

/// Stores all active locations.
/// Without this, locations reference the next locations, which reference the next locations, and so on. When a location is serialised, every location is nested into every location. This solves that by only needing to serialise the ids.
class LocationCache {
    
    private static var locations = [UUID: WeakLocation]()
    
    static func addLocation(_ location: Location) {
        Self.locations[location.id] = WeakLocation(location)
    }
    
    static func getLocation(id: UUID) -> Location {
        if let location = Self.locations[id]?.value {
            return location
        }
        // This doesn't mean the location is necessarily missing from the cache, in most cases
        // NoLocation is deallocated and wont shop up in the cache
        return NoLocation()
    }
    
    static func getLocations(ids: [UUID]) -> [Location] {
        var result = [Location]()
        for id in ids {
            result.append(Self.getLocation(id: id))
        }
        return result
    }
    
}

private class WeakLocation {
    
    weak var value: Location?
    
    init(_ location: Location) {
        self.value = location
    }
    
}
