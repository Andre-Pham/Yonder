//
//  PoolOfLocationsForArea.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

// Pool of Locations to create an Area
class AreaPool {
    
    // So getLocationArray passes references rather than new arrays with the contents copied over
    private class LocationCollection {
        var items: [LocationAbstract]
        
        init(_ items: [LocationAbstract]) {
            self.items = items
        }
    }
    
    public let areaName: String
    public let id = UUID()
    private var hostileLocations: LocationCollection
    private var challengeHostileLocations: LocationCollection
    private var shopLocations: LocationCollection
    private var enhancerLocations: LocationCollection
    private var restorerLocations: LocationCollection
    private var friendlyLocations: LocationCollection
    
    init(areaName: String, hostileLocations: [HostileLocation], challengeHostileLocations: [ChallengeHostileLocation], shopLocations: [ShopLocation], enhancerLocations: [EnhancerLocation], restorerLocations: [RestorerLocation], friendlyLocations: [FriendlyLocation]) {
        self.areaName = areaName
        self.hostileLocations = LocationCollection(hostileLocations)
        self.challengeHostileLocations = LocationCollection(challengeHostileLocations)
        self.shopLocations = LocationCollection(shopLocations)
        self.enhancerLocations = LocationCollection(enhancerLocations)
        self.restorerLocations = LocationCollection(restorerLocations)
        self.friendlyLocations = LocationCollection(friendlyLocations)
    }
    
    private func getLocationArray(of locationType: LocationType) -> LocationCollection? {
        switch locationType {
        case .hostile:
            return self.hostileLocations
        case .challengeHostile:
            return self.challengeHostileLocations
        case .shop:
            return self.shopLocations
        case .enhancer:
            return self.enhancerLocations
        case .restorer:
            return self.restorerLocations
        case .friendly:
            return self.friendlyLocations
        default:
            return nil
        }
    }
    
    private func removeLocation(location: LocationAbstract) {
        if let locationArray = self.getLocationArray(of: location.type) {
            guard let index = (locationArray.items.firstIndex { $0.id == location.id }) else {
                YonderDebugging.printError(message: "Function should find a location with a matching ID to remove", functionName: #function, className: "\(type(of: self))")
                return
            }
            locationArray.items.remove(at: index)
        }
    }
    
    func grabLocation(locationType: LocationType) -> LocationAbstract {
        if let locationArray = self.getLocationArray(of: locationType) {
            if let location = locationArray.items.randomElement() {
                self.removeLocation(location: location)
                return location
            }
        }
        YonderDebugging.printError(message: "Function grabbing location from pool shouldn't be returning NoLocation, either no locations of specified type remaining or wrong type specified", functionName: #function, className: "\(type(of: self))")
        return NoLocation()
    }
    
}
