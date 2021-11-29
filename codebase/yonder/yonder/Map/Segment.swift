//
//  Segment.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

class Segment {
    
    private(set) var leftArea: Area
    private(set) var middleArea: Area
    private(set) var rightArea: Area
    public var allAreas: [Area] {
        get {
            return [self.leftArea, self.middleArea, self.rightArea]
        }
    }
    
    init(leftArea: Area, middleArea: Area, rightArea: Area) {
        self.leftArea = leftArea
        self.middleArea = middleArea
        self.rightArea = rightArea
        
        guard (leftArea.rightBridgeLocations.count > 0 &&
               rightArea.leftBridgeLocations.count > 0 &&
               middleArea.leftBridgeLocations.count > 0 &&
               middleArea.rightBridgeLocations.count > 0) else {
            return
        }
        self.addBridgingNode(
            leftLocation: leftArea.rightBridgeLocations.randomElement()!,
            rightLocation: middleArea.leftBridgeLocations.randomElement()!,
            bridgeNode: BridgeLocation()
        )
        self.addBridgingNode(
            leftLocation: middleArea.rightBridgeLocations.randomElement()!,
            rightLocation: rightArea.leftBridgeLocations.randomElement()!,
            bridgeNode: BridgeLocation()
        )
    }
    
    func addBridgingNode(leftLocation: LocationAbstract, rightLocation: LocationAbstract, bridgeNode: BridgeLocation) {
        leftLocation.addBridgeLocation(bridgeNode)
        rightLocation.addBridgeLocation(bridgeNode)
        bridgeNode.addAdjacentLocation(leftLocation)
        bridgeNode.addAdjacentLocation(rightLocation)
    }
    
}
