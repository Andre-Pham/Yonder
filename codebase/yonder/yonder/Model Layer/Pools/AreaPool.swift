//
//  PoolOfLocationsForArea.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation
import SwiftUI

// Pool of Locations to create an Area
class AreaPool {
    
    // So getLocationArray passes references rather than new arrays with the contents copied over
    private class LocationCollection {
        var items: [Location]
        
        init(_ items: [Location]) {
            self.items = items
        }
    }
    
    public let areaName: String
    public let areaDescription: String
    public let areaImageResource: ImageResource
    public let tags: AreaProfileTagAllocation
    public let id = UUID()
    private var hostileLocations: LocationCollection
    private var challengeHostileLocations: LocationCollection
    private var shopLocations: LocationCollection
    private var enhancerLocations: LocationCollection
    private var restorerLocations: LocationCollection
    private var friendlyLocations: LocationCollection
    
    init(areaName: String, areaDescription: String, areaImageResource: ImageResource, tags: AreaProfileTagAllocation, hostileLocations: [HostileLocation], challengeHostileLocations: [ChallengeHostileLocation], shopLocations: [ShopLocation], enhancerLocations: [EnhancerLocation], restorerLocations: [RestorerLocation], friendlyLocations: [FriendlyLocation]) {
        self.areaName = areaName
        self.areaDescription = areaDescription
        self.areaImageResource = areaImageResource
        self.tags = tags
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
    
    private func removeLocation(location: Location) {
        if let locationArray = self.getLocationArray(of: location.type) {
            guard let index = (locationArray.items.firstIndex { $0.id == location.id }) else {
                assertionFailure("Function should find a location with a matching ID to remove")
                return
            }
            locationArray.items.remove(at: index)
        }
    }
    
    func grabLocation(locationType: LocationType) -> Location {
        guard let locationArray = self.getLocationArray(of: locationType),
              let location = locationArray.items.randomElement() else {
            assertionFailure("Function grabbing location from pool shouldn't be returning NoLocation, either no locations of specified type remaining or wrong type specified")
            return NoLocation()
        }
        self.removeLocation(location: location)
        return location
    }
    
}
