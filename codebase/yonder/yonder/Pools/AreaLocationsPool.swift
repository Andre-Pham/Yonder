//
//  AreaLocationsPool.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class AreaLocationsPool {
    
    private(set) var hostileLocations: [HostileLocation]
    private(set) var challengeHostileLocations: [ChallengeHostileLocation]
    private(set) var shopLocations: [ShopLocation]
    private(set) var enhancerLocations: [EnhancerLocation]
    private(set) var restorerLocations: [RestorerLocation]
    private(set) var friendlyLocations: [FriendlyLocation]
    
    init(hostileLocations: [HostileLocation], challengeHostileLocations: [ChallengeHostileLocation], shopLocations: [ShopLocation], enhancerLocations: [EnhancerLocation], restorerLocations: [RestorerLocation], friendlyLocations: [FriendlyLocation]) {
        self.hostileLocations = hostileLocations
        self.challengeHostileLocations = challengeHostileLocations
        self.shopLocations = shopLocations
        self.enhancerLocations = enhancerLocations
        self.restorerLocations = restorerLocations
        self.friendlyLocations = friendlyLocations
    }
    
    private func getLocationArray(of locationType: LocationType) -> [LocationAbstract]? {
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
        if var locationArray = self.getLocationArray(of: location.type) {
            guard let index = (locationArray.firstIndex { $0.id ==  location.id }) else {
                return
            }
            locationArray.remove(at: index)
        }
    }
    
    func grabLocation(locationType: LocationType) -> LocationAbstract {
        if let locationArray = self.getLocationArray(of: locationType) {
            if let location = locationArray.randomElement() {
                self.removeLocation(location: location)
                return location
            }
        }
        YonderDebugging.printError(message: "Function grabbing location from pool shouldn't be returning NoLocation, either no locations of specified type remaining or wrong type specified", functionName: #function, className: "\(type(of: self))")
        return NoLocation()
    }
    
}
