//
//  AreaArrangements.swift
//  yonder
//
//  Created by Andre Pham on 16/12/21.
//

import Foundation

enum AreaArrangements: String, CaseIterable {
    
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

extension Area {
    
    func generateAreaArrangement() {
        switch self.arrangement {
        case .A: self.generateAreaArrangementA()
        case .B: self.generateAreaArrangementB()
        case .C: self.generateAreaArrangementC()
        case .D: self.generateAreaArrangementD()
        case .E: self.generateAreaArrangementE()
        case .F: self.generateAreaArrangementF()
        case .G: self.generateAreaArrangementG()
        case .H: self.generateAreaArrangementH()
        case .I: self.generateAreaArrangementI()
        case .J: self.generateAreaArrangementJ()
        }
    }
    
    private func generateAreaArrangementA() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(0, 2)
        self.locations[2].setHexagonCoordinate(4, 2)
        self.locations[3].setHexagonCoordinate(2, 4)
        self.locations[4].setHexagonCoordinate(0, 6)
        self.locations[5].setHexagonCoordinate(4, 6)
        self.locations[6].setHexagonCoordinate(2, 8)
        self.locations[7].setHexagonCoordinate(3, 9)
        self.locations[8].setHexagonCoordinate(0, 10)
        self.locations[9].setHexagonCoordinate(4, 10)
        self.locations[10].setHexagonCoordinate(2, 12)
        self.locations[11].setHexagonCoordinate(0, 14)
        self.locations[12].setHexagonCoordinate(4, 14)
        self.locations[13].setHexagonCoordinate(1, 15)
        self.locations[14].setHexagonCoordinate(2, 16)
        self.locations[15].setHexagonCoordinate(4, 18)
        self.locations[16].setHexagonCoordinate(1, 19)
        self.locations[17].setHexagonCoordinate(2, 20)
        self.locations[18].setHexagonCoordinate(2, 22)
        
        self.locations[4].setBridgeAccessibility(.leftBridge)
        self.locations[5].setBridgeAccessibility(.rightBridge)
        self.locations[11].setBridgeAccessibility(.leftBridge)
        self.locations[12].setBridgeAccessibility(.rightBridge)
        
        self.addNextLocations(from: 0, to: 1, 2)
        self.addNextLocations(from: 1, to: 3, 4)
        self.addNextLocations(from: 2, to: 5)
        self.addNextLocations(from: 3, to: 6)
        self.addNextLocations(from: 4, to: 8)
        self.addNextLocations(from: 5, to: 6)
        self.addNextLocations(from: 6, to: 7, 10)
        self.addNextLocations(from: 7, to: 9)
        self.addNextLocations(from: 8, to: 10, 11)
        self.addNextLocations(from: 9, to: 12)
        self.addNextLocations(from: 10, to: 11, 12, 14)
        self.addNextLocations(from: 11, to: 13)
        self.addNextLocations(from: 12, to: 15)
        self.addNextLocations(from: 13, to: 14, 16)
        self.addNextLocations(from: 14, to: 15)
        self.addNextLocations(from: 15, to: 17)
        self.addNextLocations(from: 16, to: 17)
        self.addNextLocations(from: 17, to: 18)
    }
    
    private func generateAreaArrangementB() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(1, 1)
        self.locations[2].setHexagonCoordinate(0, 2)
        self.locations[3].setHexagonCoordinate(4, 2)
        self.locations[4].setHexagonCoordinate(4, 4)
        self.locations[5].setHexagonCoordinate(1, 5)
        self.locations[6].setHexagonCoordinate(2, 6)
        self.locations[7].setHexagonCoordinate(0, 8)
        self.locations[8].setHexagonCoordinate(4, 8)
        self.locations[9].setHexagonCoordinate(1, 9)
        self.locations[10].setHexagonCoordinate(2, 10)
        self.locations[11].setHexagonCoordinate(4, 10)
        self.locations[12].setHexagonCoordinate(3, 11)
        self.locations[13].setHexagonCoordinate(1, 13)
        self.locations[14].setHexagonCoordinate(0, 14)
        self.locations[15].setHexagonCoordinate(2, 14)
        self.locations[16].setHexagonCoordinate(3, 17)
        self.locations[17].setHexagonCoordinate(0, 18)
        self.locations[18].setHexagonCoordinate(3, 19)
        self.locations[19].setHexagonCoordinate(2, 20)
        self.locations[20].setHexagonCoordinate(2, 22)
        
        self.locations[7].setBridgeAccessibility(.leftBridge)
        self.locations[8].setBridgeAccessibility(.rightBridge)
        self.locations[14].setBridgeAccessibility(.leftBridge)
        self.locations[16].setBridgeAccessibility(.rightBridge)
        
        self.addNextLocations(from: 0, to: 1, 3)
        self.addNextLocations(from: 1, to: 2, 5)
        self.addNextLocations(from: 2, to: 7)
        self.addNextLocations(from: 3, to: 4)
        self.addNextLocations(from: 4, to: 6, 8)
        self.addNextLocations(from: 5, to: 6)
        self.addNextLocations(from: 6, to: 10)
        self.addNextLocations(from: 7, to: 9)
        self.addNextLocations(from: 8, to: 11)
        self.addNextLocations(from: 9, to: 10, 13)
        self.addNextLocations(from: 10, to: 12)
        self.addNextLocations(from: 11, to: 12)
        self.addNextLocations(from: 12, to: 16)
        self.addNextLocations(from: 13, to: 14, 15)
        self.addNextLocations(from: 14, to: 17)
        self.addNextLocations(from: 15, to: 19)
        self.addNextLocations(from: 16, to: 18)
        self.addNextLocations(from: 17, to: 19)
        self.addNextLocations(from: 18, to: 19)
        self.addNextLocations(from: 19, to: 20)
    }
    
    private func generateAreaArrangementC() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(0, 2)
        self.locations[2].setHexagonCoordinate(4, 2)
        self.locations[3].setHexagonCoordinate(1, 3)
        self.locations[4].setHexagonCoordinate(2, 4)
        self.locations[5].setHexagonCoordinate(4, 6)
        self.locations[6].setHexagonCoordinate(1, 7)
        self.locations[7].setHexagonCoordinate(0, 8)
        self.locations[8].setHexagonCoordinate(2, 8)
        self.locations[9].setHexagonCoordinate(2, 10)
        self.locations[10].setHexagonCoordinate(0, 12)
        self.locations[11].setHexagonCoordinate(4, 12)
        self.locations[12].setHexagonCoordinate(3, 13)
        self.locations[13].setHexagonCoordinate(0, 14)
        self.locations[14].setHexagonCoordinate(4, 14)
        self.locations[15].setHexagonCoordinate(3, 15)
        self.locations[16].setHexagonCoordinate(2, 16)
        self.locations[17].setHexagonCoordinate(0, 18)
        self.locations[18].setHexagonCoordinate(3, 19)
        self.locations[19].setHexagonCoordinate(2, 20)
        self.locations[20].setHexagonCoordinate(2, 22)
        
        self.locations[7].setBridgeAccessibility(.leftBridge)
        self.locations[5].setBridgeAccessibility(.rightBridge)
        self.locations[11].setBridgeAccessibility(.rightBridge)
        self.locations[13].setBridgeAccessibility(.leftBridge)
        
        self.addNextLocations(from: 0, to: 1, 2)
        self.addNextLocations(from: 1, to: 3)
        self.addNextLocations(from: 2, to: 5)
        self.addNextLocations(from: 3, to: 4, 6)
        self.addNextLocations(from: 4, to: 8)
        self.addNextLocations(from: 5, to: 8, 11)
        self.addNextLocations(from: 6, to: 7, 8)
        self.addNextLocations(from: 7, to: 10)
        self.addNextLocations(from: 8, to: 9)
        self.addNextLocations(from: 9, to: 16)
        self.addNextLocations(from: 10, to: 13)
        self.addNextLocations(from: 11, to: 12, 14)
        self.addNextLocations(from: 12, to: 15)
        self.addNextLocations(from: 13, to: 16, 17)
        self.addNextLocations(from: 14, to: 15)
        self.addNextLocations(from: 15, to: 16, 18)
        self.addNextLocations(from: 16, to: 19)
        self.addNextLocations(from: 17, to: 19)
        self.addNextLocations(from: 18, to: 19)
        self.addNextLocations(from: 19, to: 20)
    }
    
    private func generateAreaArrangementD() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(0, 2)
        self.locations[2].setHexagonCoordinate(2, 2)
        self.locations[3].setHexagonCoordinate(4, 2)
        self.locations[4].setHexagonCoordinate(2, 4)
        self.locations[5].setHexagonCoordinate(0, 6)
        self.locations[6].setHexagonCoordinate(4, 6)
        self.locations[7].setHexagonCoordinate(2, 8)
        self.locations[8].setHexagonCoordinate(0, 10)
        self.locations[9].setHexagonCoordinate(4, 10)
        self.locations[10].setHexagonCoordinate(0, 14)
        self.locations[11].setHexagonCoordinate(2, 14)
        self.locations[12].setHexagonCoordinate(2, 16)
        self.locations[13].setHexagonCoordinate(4, 16)
        self.locations[14].setHexagonCoordinate(0, 18)
        self.locations[15].setHexagonCoordinate(2, 18)
        self.locations[16].setHexagonCoordinate(2, 20)
        self.locations[17].setHexagonCoordinate(2, 22)
        
        self.locations[5].setBridgeAccessibility(.leftBridge)
        self.locations[6].setBridgeAccessibility(.rightBridge)
        self.locations[8].setBridgeAccessibility(.leftBridge)
        self.locations[9].setBridgeAccessibility(.rightBridge)
        
        self.addNextLocations(from: 0, to: 1, 2, 3)
        self.addNextLocations(from: 1, to: 4, 5)
        self.addNextLocations(from: 2, to: 4)
        self.addNextLocations(from: 3, to: 4, 6)
        self.addNextLocations(from: 4, to: 7)
        self.addNextLocations(from: 5, to: 7, 8)
        self.addNextLocations(from: 6, to: 7, 9)
        self.addNextLocations(from: 7, to: 8, 9, 11)
        self.addNextLocations(from: 8, to: 10)
        self.addNextLocations(from: 9, to: 13)
        self.addNextLocations(from: 10, to: 12)
        self.addNextLocations(from: 11, to: 12, 13)
        self.addNextLocations(from: 12, to: 14, 15)
        self.addNextLocations(from: 13, to: 15)
        self.addNextLocations(from: 14, to: 16)
        self.addNextLocations(from: 15, to: 16)
        self.addNextLocations(from: 16, to: 17)
    }
    
    private func generateAreaArrangementE() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(0, 2)
        self.locations[2].setHexagonCoordinate(4, 2)
        self.locations[3].setHexagonCoordinate(0, 6)
        self.locations[4].setHexagonCoordinate(4, 6)
        self.locations[5].setHexagonCoordinate(1, 7)
        self.locations[6].setHexagonCoordinate(3, 7)
        self.locations[7].setHexagonCoordinate(2, 8)
        self.locations[8].setHexagonCoordinate(4, 10)
        self.locations[9].setHexagonCoordinate(1, 11)
        self.locations[10].setHexagonCoordinate(0, 12)
        self.locations[11].setHexagonCoordinate(2, 12)
        self.locations[12].setHexagonCoordinate(4, 12)
        self.locations[13].setHexagonCoordinate(0, 16)
        self.locations[14].setHexagonCoordinate(4, 16)
        self.locations[15].setHexagonCoordinate(0, 18)
        self.locations[16].setHexagonCoordinate(2, 18)
        self.locations[17].setHexagonCoordinate(2, 20)
        self.locations[18].setHexagonCoordinate(2, 22)
        
        self.locations[3].setBridgeAccessibility(.leftBridge)
        self.locations[4].setBridgeAccessibility(.rightBridge)
        self.locations[10].setBridgeAccessibility(.leftBridge)
        self.locations[12].setBridgeAccessibility(.rightBridge)
        
        self.addNextLocations(from: 0, to: 1, 2)
        self.addNextLocations(from: 1, to: 3)
        self.addNextLocations(from: 2, to: 3, 4)
        self.addNextLocations(from: 3, to: 5)
        self.addNextLocations(from: 4, to: 6, 8)
        self.addNextLocations(from: 5, to: 9)
        self.addNextLocations(from: 6, to: 7)
        self.addNextLocations(from: 7, to: 11)
        self.addNextLocations(from: 8, to: 11, 12)
        self.addNextLocations(from: 9, to: 10, 11)
        self.addNextLocations(from: 10, to: 13)
        self.addNextLocations(from: 11, to: 16)
        self.addNextLocations(from: 12, to: 14)
        self.addNextLocations(from: 13, to: 15, 16)
        self.addNextLocations(from: 14, to: 16)
        self.addNextLocations(from: 15, to: 17)
        self.addNextLocations(from: 16, to: 17)
        self.addNextLocations(from: 17, to: 18)
    }
    
    private func generateAreaArrangementF() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(1, 1)
        self.locations[2].setHexagonCoordinate(3, 1)
        self.locations[3].setHexagonCoordinate(0, 2)
        self.locations[4].setHexagonCoordinate(2, 2)
        self.locations[5].setHexagonCoordinate(0, 4)
        self.locations[6].setHexagonCoordinate(2, 4)
        self.locations[7].setHexagonCoordinate(3, 5)
        self.locations[8].setHexagonCoordinate(4, 6)
        self.locations[9].setHexagonCoordinate(0, 8)
        self.locations[10].setHexagonCoordinate(2, 10)
        self.locations[11].setHexagonCoordinate(4, 10)
        self.locations[12].setHexagonCoordinate(0, 12)
        self.locations[13].setHexagonCoordinate(1, 13)
        self.locations[14].setHexagonCoordinate(0, 14)
        self.locations[15].setHexagonCoordinate(4, 16)
        self.locations[16].setHexagonCoordinate(1, 17)
        self.locations[17].setHexagonCoordinate(0, 18)
        self.locations[18].setHexagonCoordinate(2, 18)
        self.locations[19].setHexagonCoordinate(4, 18)
        self.locations[20].setHexagonCoordinate(2, 20)
        self.locations[21].setHexagonCoordinate(2, 22)
        
        self.locations[8].setBridgeAccessibility(.rightBridge)
        self.locations[9].setBridgeAccessibility(.leftBridge)
        self.locations[11].setBridgeAccessibility(.rightBridge)
        self.locations[14].setBridgeAccessibility(.leftBridge)
        
        self.addNextLocations(from: 0, to: 1, 2, 4)
        self.addNextLocations(from: 1, to: 3)
        self.addNextLocations(from: 2, to: 7)
        self.addNextLocations(from: 3, to: 5, 6)
        self.addNextLocations(from: 4, to: 6)
        self.addNextLocations(from: 5, to: 9)
        self.addNextLocations(from: 6, to: 7, 10)
        self.addNextLocations(from: 7, to: 8)
        self.addNextLocations(from: 8, to: 11)
        self.addNextLocations(from: 9, to: 10)
        self.addNextLocations(from: 10, to: 12)
        self.addNextLocations(from: 11, to: 13)
        self.addNextLocations(from: 12, to: 13)
        self.addNextLocations(from: 13, to: 14, 15, 16)
        self.addNextLocations(from: 14, to: 17)
        self.addNextLocations(from: 15, to: 18, 19)
        self.addNextLocations(from: 16, to: 18)
        self.addNextLocations(from: 17, to: 20)
        self.addNextLocations(from: 18, to: 20)
        self.addNextLocations(from: 19, to: 20)
        self.addNextLocations(from: 20, to: 21)
    }
    
    private func generateAreaArrangementG() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(0, 2)
        self.locations[2].setHexagonCoordinate(4, 2)
        self.locations[3].setHexagonCoordinate(2, 4)
        self.locations[4].setHexagonCoordinate(2, 6)
        self.locations[5].setHexagonCoordinate(4, 6)
        self.locations[6].setHexagonCoordinate(3, 7)
        self.locations[7].setHexagonCoordinate(0, 8)
        self.locations[8].setHexagonCoordinate(2, 10)
        self.locations[9].setHexagonCoordinate(4, 10)
        self.locations[10].setHexagonCoordinate(3, 11)
        self.locations[11].setHexagonCoordinate(0, 12)
        self.locations[12].setHexagonCoordinate(4, 12)
        self.locations[13].setHexagonCoordinate(2, 14)
        self.locations[14].setHexagonCoordinate(0, 16)
        self.locations[15].setHexagonCoordinate(2, 16)
        self.locations[16].setHexagonCoordinate(1, 17)
        self.locations[17].setHexagonCoordinate(4, 18)
        self.locations[18].setHexagonCoordinate(3, 19)
        self.locations[19].setHexagonCoordinate(2, 20)
        self.locations[20].setHexagonCoordinate(2, 22)
        
        self.locations[5].setBridgeAccessibility(.rightBridge)
        self.locations[7].setBridgeAccessibility(.leftBridge)
        self.locations[12].setBridgeAccessibility(.rightBridge)
        self.locations[14].setBridgeAccessibility(.leftBridge)
        
        self.addNextLocations(from: 0, to: 1, 2)
        self.addNextLocations(from: 1, to: 3, 7)
        self.addNextLocations(from: 2, to: 3, 5)
        self.addNextLocations(from: 3, to: 4)
        self.addNextLocations(from: 4, to: 6, 7)
        self.addNextLocations(from: 5, to: 9)
        self.addNextLocations(from: 6, to: 10)
        self.addNextLocations(from: 7, to: 11)
        self.addNextLocations(from: 8, to: 11, 13)
        self.addNextLocations(from: 9, to: 12)
        self.addNextLocations(from: 10, to: 12)
        self.addNextLocations(from: 11, to: 14)
        self.addNextLocations(from: 12, to: 13)
        self.addNextLocations(from: 13, to: 15)
        self.addNextLocations(from: 14, to: 16)
        self.addNextLocations(from: 15, to: 17)
        self.addNextLocations(from: 16, to: 18)
        self.addNextLocations(from: 17, to: 18)
        self.addNextLocations(from: 18, to: 19)
        self.addNextLocations(from: 19, to: 20)
    }
    
    private func generateAreaArrangementH() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(1, 1)
        self.locations[2].setHexagonCoordinate(2, 2)
        self.locations[3].setHexagonCoordinate(4, 2)
        self.locations[4].setHexagonCoordinate(0, 4)
        self.locations[5].setHexagonCoordinate(2, 4)
        self.locations[6].setHexagonCoordinate(1, 5)
        self.locations[7].setHexagonCoordinate(2, 6)
        self.locations[8].setHexagonCoordinate(4, 6)
        self.locations[9].setHexagonCoordinate(1, 9)
        self.locations[10].setHexagonCoordinate(0, 10)
        self.locations[11].setHexagonCoordinate(4, 10)
        self.locations[12].setHexagonCoordinate(2, 12)
        self.locations[13].setHexagonCoordinate(0, 14)
        self.locations[14].setHexagonCoordinate(4, 14)
        self.locations[15].setHexagonCoordinate(0, 18)
        self.locations[16].setHexagonCoordinate(4, 18)
        self.locations[17].setHexagonCoordinate(2, 20)
        self.locations[18].setHexagonCoordinate(2, 22)
        
        self.locations[4].setBridgeAccessibility(.leftBridge)
        self.locations[8].setBridgeAccessibility(.rightBridge)
        self.locations[13].setBridgeAccessibility(.leftBridge)
        self.locations[14].setBridgeAccessibility(.rightBridge)
        
        self.addNextLocations(from: 0, to: 1, 3)
        self.addNextLocations(from: 1, to: 2)
        self.addNextLocations(from: 2, to: 4)
        self.addNextLocations(from: 3, to: 5)
        self.addNextLocations(from: 4, to: 6, 10)
        self.addNextLocations(from: 5, to: 6, 7, 8)
        self.addNextLocations(from: 6, to: 9)
        self.addNextLocations(from: 7, to: 12)
        self.addNextLocations(from: 8, to: 11)
        self.addNextLocations(from: 9, to: 10)
        self.addNextLocations(from: 10, to: 12)
        self.addNextLocations(from: 11, to: 12)
        self.addNextLocations(from: 12, to: 13, 17, 14)
        self.addNextLocations(from: 13, to: 15)
        self.addNextLocations(from: 14, to: 16)
        self.addNextLocations(from: 15, to: 17)
        self.addNextLocations(from: 16, to: 17)
        self.addNextLocations(from: 17, to: 18)
    }
    
    private func generateAreaArrangementI() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(1, 1)
        self.locations[2].setHexagonCoordinate(3, 1)
        self.locations[3].setHexagonCoordinate(4, 2)
        self.locations[4].setHexagonCoordinate(1, 3)
        self.locations[5].setHexagonCoordinate(0, 4)
        self.locations[6].setHexagonCoordinate(4, 6)
        self.locations[7].setHexagonCoordinate(0, 12)
        self.locations[8].setHexagonCoordinate(1, 13)
        self.locations[9].setHexagonCoordinate(0, 14)
        self.locations[10].setHexagonCoordinate(4, 14)
        self.locations[11].setHexagonCoordinate(1, 15)
        self.locations[12].setHexagonCoordinate(3, 15)
        self.locations[13].setHexagonCoordinate(3, 17)
        self.locations[14].setHexagonCoordinate(0, 18)
        self.locations[15].setHexagonCoordinate(4, 18)
        self.locations[16].setHexagonCoordinate(1, 19)
        self.locations[17].setHexagonCoordinate(3, 19)
        self.locations[18].setHexagonCoordinate(2, 20)
        self.locations[19].setHexagonCoordinate(2, 22)
        
        self.locations[6].setBridgeAccessibility(.rightBridge)
        self.locations[7].setBridgeAccessibility(.leftBridge)
        self.locations[9].setBridgeAccessibility(.leftBridge)
        self.locations[10].setBridgeAccessibility(.rightBridge)
        
        self.addNextLocations(from: 0, to: 1, 2)
        self.addNextLocations(from: 1, to: 4)
        self.addNextLocations(from: 2, to: 3)
        self.addNextLocations(from: 3, to: 6)
        self.addNextLocations(from: 4, to: 5, 6)
        self.addNextLocations(from: 5, to: 7)
        self.addNextLocations(from: 6, to: 10)
        self.addNextLocations(from: 7, to: 8)
        self.addNextLocations(from: 8, to: 9, 11)
        self.addNextLocations(from: 9, to: 14)
        self.addNextLocations(from: 10, to: 12, 15)
        self.addNextLocations(from: 11, to: 16)
        self.addNextLocations(from: 12, to: 13)
        self.addNextLocations(from: 13, to: 16)
        self.addNextLocations(from: 14, to: 16)
        self.addNextLocations(from: 15, to: 17)
        self.addNextLocations(from: 16, to: 18)
        self.addNextLocations(from: 17, to: 18)
        self.addNextLocations(from: 18, to: 19)
    }
    
    private func generateAreaArrangementJ() {
        self.locations[0].setHexagonCoordinate(2, 0)
        self.locations[1].setHexagonCoordinate(1, 1)
        self.locations[2].setHexagonCoordinate(4, 2)
        self.locations[3].setHexagonCoordinate(1, 3)
        self.locations[4].setHexagonCoordinate(3, 3)
        self.locations[5].setHexagonCoordinate(0, 4)
        self.locations[6].setHexagonCoordinate(2, 4)
        self.locations[7].setHexagonCoordinate(4, 6)
        self.locations[8].setHexagonCoordinate(2, 8)
        self.locations[9].setHexagonCoordinate(4, 8)
        self.locations[10].setHexagonCoordinate(3, 9)
        self.locations[11].setHexagonCoordinate(0, 10)
        self.locations[12].setHexagonCoordinate(3, 13)
        self.locations[13].setHexagonCoordinate(4, 14)
        self.locations[14].setHexagonCoordinate(0, 16)
        self.locations[15].setHexagonCoordinate(2, 16)
        self.locations[16].setHexagonCoordinate(0, 18)
        self.locations[17].setHexagonCoordinate(4, 18)
        self.locations[18].setHexagonCoordinate(2, 20)
        self.locations[19].setHexagonCoordinate(2, 22)
        
        self.locations[7].setBridgeAccessibility(.rightBridge)
        self.locations[11].setBridgeAccessibility(.leftBridge)
        self.locations[13].setBridgeAccessibility(.rightBridge)
        self.locations[14].setBridgeAccessibility(.leftBridge)
        
        self.addNextLocations(from: 0, to: 1, 2, 6)
        self.addNextLocations(from: 1, to: 3)
        self.addNextLocations(from: 2, to: 4, 7)
        self.addNextLocations(from: 3, to: 5, 6)
        self.addNextLocations(from: 4, to: 6)
        self.addNextLocations(from: 5, to: 11)
        self.addNextLocations(from: 6, to: 8)
        self.addNextLocations(from: 7, to: 8, 9)
        self.addNextLocations(from: 8, to: 10, 11)
        self.addNextLocations(from: 9, to: 10, 13)
        self.addNextLocations(from: 10, to: 12)
        self.addNextLocations(from: 11, to: 12)
        self.addNextLocations(from: 12, to: 13, 14)
        self.addNextLocations(from: 13, to: 15)
        self.addNextLocations(from: 14, to: 16)
        self.addNextLocations(from: 15, to: 17, 18)
        self.addNextLocations(from: 16, to: 18)
        self.addNextLocations(from: 17, to: 18)
        self.addNextLocations(from: 18, to: 19)
    }
    
}
