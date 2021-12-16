//
//  AreaArrangements.swift
//  yonder
//
//  Created by Andre Pham on 16/12/21.
//

import Foundation

extension Area {
    
    enum AreaArrangements {
        
        case A; case B; case C; case D; case E; case F; case G; case H; case I; case J
        
        var locationCount: Int {
            switch self {
            case .A: return 19
            case .B: return 21
            case .C: return 21
            case .D: return 18
            case .E: return 19
            case .F: return 22
            case .G: return 21
            case .H: return 19
            case .I: return 20
            case .J: return 20
            }
        }
        
    }
    
    func generateAreaArrangement(locations: [LocationAbstract]) {
        switch self.arrangement {
        case .A: generateAreaArrangementA(locations: locations)
        case .B: return
        case .C: return
        case .D: return
        case .E: return
        case .F: return
        case .G: return
        case .H: return
        case .I: return
        case .J: return
        }
    }
    
    private func generateAreaArrangementA(locations: [LocationAbstract]) {
        locations[0].setHexagonCoordinate(2, 0)
        locations[1].setHexagonCoordinate(0, 2)
        locations[2].setHexagonCoordinate(4, 2)
        locations[3].setHexagonCoordinate(2, 4)
        locations[4].setHexagonCoordinate(0, 6)
        locations[5].setHexagonCoordinate(4, 6)
        locations[6].setHexagonCoordinate(2, 8)
        locations[7].setHexagonCoordinate(3, 9)
        locations[8].setHexagonCoordinate(0, 10)
        locations[9].setHexagonCoordinate(4, 10)
        locations[10].setHexagonCoordinate(2, 12)
        locations[11].setHexagonCoordinate(0, 14)
        locations[12].setHexagonCoordinate(4, 14)
        locations[13].setHexagonCoordinate(1, 15)
        locations[14].setHexagonCoordinate(2, 16)
        locations[15].setHexagonCoordinate(4, 18)
        locations[16].setHexagonCoordinate(1, 19)
        locations[17].setHexagonCoordinate(2, 20)
        locations[18].setHexagonCoordinate(2, 22)
        
        locations[4].setBridgeAccessibility(.leftBridge)
        locations[5].setBridgeAccessibility(.rightBridge)
        locations[11].setBridgeAccessibility(.leftBridge)
        locations[12].setBridgeAccessibility(.rightBridge)
        
        self.addNextLocations(from: locations[0], to: [locations[1], locations[2]])
        self.addNextLocations(from: locations[1], to: [locations[3], locations[4]])
        self.addNextLocations(from: locations[2], to: [locations[5]])
        self.addNextLocations(from: locations[3], to: [locations[6]])
        self.addNextLocations(from: locations[4], to: [locations[8]])
        self.addNextLocations(from: locations[5], to: [locations[6]])
        self.addNextLocations(from: locations[6], to: [locations[7], locations[10]])
        self.addNextLocations(from: locations[7], to: [locations[9]])
        self.addNextLocations(from: locations[8], to: [locations[10], locations[11]])
        self.addNextLocations(from: locations[9], to: [locations[12]])
        self.addNextLocations(from: locations[10], to: [locations[11], locations[12], locations[14]])
        self.addNextLocations(from: locations[11], to: [locations[13]])
        self.addNextLocations(from: locations[12], to: [locations[15]])
        self.addNextLocations(from: locations[13], to: [locations[14], locations[16]])
        self.addNextLocations(from: locations[14], to: [locations[15]])
        self.addNextLocations(from: locations[15], to: [locations[17]])
        self.addNextLocations(from: locations[16], to: [locations[17]])
        self.addNextLocations(from: locations[17], to: [locations[18]])
    }
    
}
