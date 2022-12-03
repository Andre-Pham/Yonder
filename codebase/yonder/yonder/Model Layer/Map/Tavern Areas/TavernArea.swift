//
//  TavernArea.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

class TavernArea: Storable {
    
    private(set) var rootLocations = [Location]()
    private(set) var tipLocations = [Location]()
    public let arrangement: TavernAreaArrangements
    public let locations: [Location]
    
    init(restorer: RestorerLocation, potionShop: ShopLocation, enhancer: EnhancerLocation) {
        self.arrangement = .S
        self.locations = [restorer, potionShop, enhancer]
        self.addRootAndTipLocations()
        self.generateAreaArrangement()
    }
    
    init(restorer: RestorerLocation, potionShop: ShopLocation, enhancer: EnhancerLocation, otherShop: ShopLocation) {
        self.arrangement = .M
        self.locations = [restorer, potionShop, enhancer, otherShop]
        self.addRootAndTipLocations()
        self.generateAreaArrangement()
    }
    
    init(restorer: RestorerLocation, potionShop: ShopLocation, enhancer: EnhancerLocation, otherShop: ShopLocation, friendly: FriendlyLocation) {
        self.arrangement = .L
        self.locations = [restorer, potionShop, enhancer, otherShop, friendly]
        self.addRootAndTipLocations()
        self.generateAreaArrangement()
    }
    
    init(restorer: RestorerLocation, potionShop: ShopLocation, enhancer: EnhancerLocation, otherShop: ShopLocation, friendly: FriendlyLocation, secondFriendly: FriendlyLocation) {
        self.arrangement = .XL
        self.locations = [restorer, potionShop, enhancer, otherShop, friendly, secondFriendly]
        self.addRootAndTipLocations()
        self.generateAreaArrangement()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case arrangement
        case locations
    }

    required init(dataObject: DataObject) {
        self.arrangement = TavernAreaArrangements(rawValue: dataObject.get(Field.arrangement.rawValue)) ?? .S
        self.locations = dataObject.getObjectArray(Field.locations.rawValue, type: LocationAbstract.self) as! [any Location]
        self.addRootAndTipLocations()
        // We don't re-generate area arrangement because the serialised locations already have that data
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.arrangement.rawValue, value: self.arrangement.rawValue)
            .add(key: Field.locations.rawValue, value: self.locations as [LocationAbstract])
    }

    // MARK: - Functions
    
    func addRootLocations(_ locations: [Location]) {
        self.rootLocations.append(contentsOf: locations)
    }
    
    func addRootLocations(_ locationIndices: Int...) {
        let locations = locationIndices.map { self.locations[$0] }
        self.addRootLocations(locations)
    }
    
    func addTipLocations(_ locations: [Location]) {
        self.tipLocations.append(contentsOf: locations)
    }
    
    func addTipLocations(_ locationIndices: Int...) {
        let locations = locationIndices.map { self.locations[$0] }
        self.addTipLocations(locations)
    }
    
    func addNextLocations(from location: Location, to nextLocations: [Location]) {
        location.addNextLocations(nextLocations)
    }
    
    func addNextLocations(from locationIndex: Int, to nextLocationIndices: Int...) {
        let location = self.locations[locationIndex]
        let nextLocations = nextLocationIndices.map { self.locations[$0] }
        self.addNextLocations(from: location, to: nextLocations)
    }
    
    func createUndirectedEdge(between location: Location, and otherLocation: Location) {
        location.addNextLocations([otherLocation])
        otherLocation.addNextLocations([location])
    }
    
    func createUndirectedEdge(between locationIndex: Int, and otherLocationIndex: Int) {
        let location = self.locations[locationIndex]
        let otherLocation = self.locations[otherLocationIndex]
        self.createUndirectedEdge(between: location, and: otherLocation)
    }

}
