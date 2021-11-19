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
    
    init(leftArea: Area, middleArea: Area, rightArea: Area) {
        self.leftArea = leftArea
        self.middleArea = middleArea
        self.rightArea = rightArea
    }
    
    func addBridgingNode(leftLocation: Location, rightLocation: Location, bridgeNode: BridgeLocation) {
        leftLocation.addBridgeLocation(bridgeNode)
        rightLocation.addBridgeLocation(bridgeNode)
        bridgeNode.addAdjacentLocation(leftLocation)
        bridgeNode.addAdjacentLocation(rightLocation)
    }
    
}
