//
//  LocationViewModel.swift
//  yonder
//
//  Created by Andre Pham on 25/1/2022.
//

import Foundation
import Combine
import SwiftUI

class LocationViewModel: ObservableObject {
    
    private(set) var location: LocationAbstract
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var hasBeenVisited: Bool
    @Published private(set) var locationIDsArrivedFrom: [UUID]
    private(set) var id: UUID
    private(set) var name: String
    private(set) var description: String
    private(set) var image: Image
    private(set) var type: LocationType
    private(set) var nextLocationIDs: [UUID]
    var typeAsString: String {
        return self.convertTypeToString(self.type)
    }
    var isBridge: Bool {
        return self.location is BridgeLocation
    }
    
    init(_ location: LocationAbstract) {
        self.location = location
        
        // Set properties to match Location
        
        self.hasBeenVisited = self.location.hasBeenVisited
        self.locationIDsArrivedFrom = self.location.locationsArrivedFrom.map { $0.id }
        self.id = self.location.id
        self.name = location.areaContent.name
        self.description = location.areaContent.description
        self.image = location.areaContent.image
        self.type = location.type
        self.nextLocationIDs = self.location.nextLocations.map { $0.id }
        if let bridgeLocation = self.location.bridgeLocation {
            self.nextLocationIDs.append(bridgeLocation.id)
        }
        
        // Add Subscribers
        
        self.location.$hasBeenVisited.sink(receiveValue: { newValue in
            self.hasBeenVisited = newValue
        }).store(in: &self.subscriptions)
        
        self.location.$locationsArrivedFrom.sink(receiveValue: { newValue in
            if let newID = newValue.last?.id {
                self.locationIDsArrivedFrom.append(newID)
            }
        }).store(in: &self.subscriptions)
    }
    
    func canBeTravelledTo(from locationViewModel: LocationViewModel) -> Bool {
        for id in locationViewModel.nextLocationIDs {
            if id == self.id {
                return true
            }
        }
        return false
    }
    
    func convertTypeToString(_ type: LocationType) -> String {
        switch type {
        case .none:
            return "None"
        case .boss:
            return "Boss"
        case .challengeHostile:
            return "Mini Boss"
        case .enhancer:
            return "Enhancer"
        case .friendly:
            return "Wanderer"
        case .hostile:
            return "Hostile"
        case .quest:
            return "Quest"
        case .restorer:
            return "Restorer"
        case .shop:
            return "Shop"
        }
    }
    
}

/// A lot of LocationViewModels can exist at once so this is a lightweight version that contains less information and no subscribers or publishers.
struct LightweightLocationViewModel {
    
    private let location: LocationAbstract
    var isBridge: Bool {
        return self.location is BridgeLocation
    }
    var id: UUID {
        return self.location.id
    }
    
    init(_ location: LocationAbstract) {
        self.location = location
    }
    
}
