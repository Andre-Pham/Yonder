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
    
    // location can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var location: Location
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var hasBeenVisited: Bool
    @Published private(set) var locationIDsArrivedFrom: [UUID]
    private(set) var id: UUID
    private(set) var name: String
    private(set) var description: String
    /// The location's region's background image for location tiles (hexagons on the map)
    /// IMPORTANT: Must remain as `YonderImage` (not `SwiftUI.Image`) due to requiring its width/height dimensions
    private(set) var tileBackgroundImage: YonderImage
    /// The location's region's platform image (what the NPC stands for - search "battle platform" in Pokemon)
    /// IMPORTANT: Must remain as `YonderImage` (not `SwiftUI.Image`) due to requiring its width/height dimensions
    private(set) var platformImage: YonderImage
    private(set) var type: LocationType
    private(set) var nextLocationIDs: [UUID]
    var isBridge: Bool {
        return self.location is BridgeLocation
    }
    var playerCanEngage: Bool {
        if let foeLocation = self.location as? FoeLocation {
            return !foeLocation.foe.isDead
        }
        return false
    }
    var playerHasOffers: Bool {
        if let offerLocation = self.location as? FriendlyLocation {
            return !offerLocation.friendly.offers.isEmpty
        }
        return false
    }
    var playerCanPurchaseRestoration: Bool {
        if let restoreLocation = self.location as? RestorerLocation {
            return !restoreLocation.restorer.options.isEmpty
        }
        return false
    }
    var playerCanShop: Bool {
        if let shopLocation = self.location as? ShopLocation {
            return !shopLocation.shopKeeper.purchasableItems.isEmpty
        }
        return false
    }
    var playerCanEnhance: Bool {
        if let enhanceLocation = self.location as? EnhancerLocation {
            return !enhanceLocation.enhancer.enhanceOffers.isEmpty
        }
        return false
    }
    var playerCanChooseLootBag: Bool {
        if let foeViewModel = self.location as? FoeLocation {
            return foeViewModel.foe.canBeLooted
        }
        return false
    }
    var playerHasLootChoiceAvailable: Bool {
        if let foeViewModel = self.location as? FoeLocation {
            return foeViewModel.foe.hasLootChoiceAvailable
        }
        return false
    }
    
    init(_ location: Location) {
        self.location = location
        
        // Set properties to match Location
        
        self.hasBeenVisited = self.location.hasBeenVisited
        self.locationIDsArrivedFrom = self.location.locationIDsArrivedFrom
        self.id = self.location.id
        self.name = location.context.name
        self.description = location.context.description
        self.tileBackgroundImage = location.context.tileBackgroundImage
        self.platformImage = location.context.platformImage
        self.type = location.type
        self.nextLocationIDs = self.location.nextLocations.map { $0.id }
        if let bridgeLocation = self.location.bridgeLocation {
            self.nextLocationIDs.append(bridgeLocation.id)
        }
        
        // Add Subscribers
        
        self.location.$hasBeenVisited.sink(receiveValue: { newValue in
            self.hasBeenVisited = newValue
        }).store(in: &self.subscriptions)
        
        self.location.$locationIDsArrivedFrom.sink(receiveValue: { newValue in
            if let newID = newValue.last {
                self.locationIDsArrivedFrom.append(newID)
            }
        }).store(in: &self.subscriptions)
    }
    
    func getBridgeConnectedAreaViewModels() -> (AreaViewModel, AreaViewModel)? {
        if !self.isBridge || self.location.nextLocations.count != 2 {
            return nil
        }
        return (AreaViewModel(locationContext: self.location.nextLocations[0].context),
                AreaViewModel(locationContext: self.location.nextLocations[1].context))
    }
    
    func getBridgeConnectedLocationViewModels() -> (LocationViewModel, LocationViewModel)? {
        if !self.isBridge || self.location.nextLocations.count != 2 {
            return nil
        }
        return (LocationViewModel(self.location.nextLocations[0]), LocationViewModel(self.location.nextLocations[1]))
    }
    
    func getInteractorViewModel() -> InteractorViewModel? {
        switch self.type {
        case .none:
            return nil
        case .hostile:
            return nil
        case .challengeHostile:
            return nil
        case .shop:
            return ShopKeeperViewModel((self.location as! ShopLocation).shopKeeper)
        case .enhancer:
            return EnhancerViewModel((self.location as! EnhancerLocation).enhancer)
        case .restorer:
            return RestorerViewModel((self.location as! RestorerLocation).restorer)
        case .friendly:
            return FriendlyViewModel((self.location as! FriendlyLocation).friendly)
        case .boss:
            return nil
        case .bridge:
            return nil
        case .starting:
            return nil
        }
    }
    
    func getFoeViewModel() -> FoeViewModel? {
        switch self.type {
        case .none:
            return nil
        case .hostile:
            return FoeViewModel((self.location as! HostileLocation).foe)
        case .challengeHostile:
            return FoeViewModel((self.location as! ChallengeHostileLocation).foe)
        case .shop:
            return nil
        case .enhancer:
            return nil
        case .restorer:
            return nil
        case .friendly:
            return nil
        case .boss:
            return FoeViewModel((self.location as! BossLocation).foe)
        case .bridge:
            return nil
        case .starting:
            return nil
        }
    }
    
    func getNPCName() -> String? {
        if let name = self.getFoeViewModel()?.name {
            return name
        }
        if let name = self.getInteractorViewModel()?.name {
            return name
        }
        return nil
    }
    
    func canBeTravelledTo(from locationViewModel: LocationViewModel) -> Bool {
        for id in locationViewModel.nextLocationIDs {
            if id == self.id {
                return true
            }
        }
        return false
    }
    
    func getTypeName() -> String {
        return self.type.name
    }
    
    func getTypeImage() -> Image {
        return self.type.image
    }
    
}

/// A lot of LocationViewModels can exist at once so this is a lightweight version that contains less information and no subscribers or publishers.
struct LightweightLocationViewModel {
    
    private let location: Location
    var isBridge: Bool {
        return self.location is BridgeLocation
    }
    var id: UUID {
        return self.location.id
    }
    
    init(_ location: Location) {
        self.location = location
    }
    
}
