//
//  Segment.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Segment: Storable {
    
    private(set) var leftArea: Area
    private(set) var rightArea: Area
    private(set) var bridgeLocation: BridgeLocation
    public var allAreas: [Area] {
        get {
            return [self.leftArea, self.rightArea]
        }
    }
    
    init(leftArea: Area, rightArea: Area) {
        self.leftArea = leftArea
        self.rightArea = rightArea
        self.bridgeLocation = BridgeLocation()
        assert(leftArea.rightBridgeLocations.count > 0 && rightArea.leftBridgeLocations.count > 0, "Segment Areas were defined without bridge locations")
        var leftAreaBridgeLocation = leftArea.rightBridgeLocations.randomElement()!
        var rightAreaBridgeLocation = rightArea.leftBridgeLocations.randomElement()!
        if leftAreaBridgeLocation.hexagonCoordinate!.y == rightAreaBridgeLocation.hexagonCoordinate!.y {
            let illegalY = leftAreaBridgeLocation.hexagonCoordinate!.y
            let reducedAreaIsLeft: Bool = leftArea.rightBridgeLocations.count > rightArea.leftBridgeLocations.count
            if reducedAreaIsLeft {
                leftArea.filterRightBridgeLocationsWithY(of: illegalY)
                leftAreaBridgeLocation = leftArea.rightBridgeLocations.randomElement()!
            }
            else {
                rightArea.filterLeftBridgeLocationsWithY(of: illegalY)
                rightAreaBridgeLocation = rightArea.leftBridgeLocations.randomElement()!
            }
        }
        self.addBridgingNode(
            leftLocation: leftAreaBridgeLocation,
            rightLocation: rightAreaBridgeLocation,
            bridgeNode: self.bridgeLocation)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case leftArea
        case rightArea
        case bridgeLocation
    }

    required init(dataObject: DataObject) {
        self.leftArea = dataObject.getObject(Field.leftArea.rawValue, type: Area.self)
        self.rightArea = dataObject.getObject(Field.rightArea.rawValue, type: Area.self)
        self.bridgeLocation = dataObject.getObject(Field.bridgeLocation.rawValue, type: BridgeLocation.self)
    }

    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.leftArea.rawValue, value: self.leftArea)
            .add(key: Field.rightArea.rawValue, value: self.rightArea)
            .add(key: Field.bridgeLocation.rawValue, value: self.bridgeLocation)
    }

    // MARK: - Functions
    
    func addBridgingNode(leftLocation: Location, rightLocation: Location, bridgeNode: BridgeLocation) {
        leftLocation.setBridgeLocation(bridgeNode)
        rightLocation.setBridgeLocation(bridgeNode)
        bridgeNode.addNextLocations([leftLocation, rightLocation])
        var yCoordinate: Int = (leftLocation.hexagonCoordinate!.y + rightLocation.hexagonCoordinate!.y)/2
        yCoordinate += yCoordinate%2 == 0 ? 1 : 0
        bridgeNode.setHexagonCoordinate(5, yCoordinate)
    }
    
}
