//
//  TavernAreaArrangements.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

enum TavernAreaArrangements: String, CaseIterable {
    
    case S // Small
    case M // Medium
    case L // Large
    case XL // Extra Large
    
    var locationCount: Int {
        switch self {
        case .S: return 3
        case .M: return 4
        case .L: return 5
        case .XL: return 6
        }
    }
    
}

extension TavernArea {
    
    func addRootAndTipLocations() {
        switch self.arrangement {
        case .S: self.addRootAndTipLocationsS()
        case .M: self.addRootAndTipLocationsM()
        case .L: self.addRootAndTipLocationsL()
        case .XL: self.addRootAndTipLocationsXL()
        }
    }
    
    func generateAreaArrangement() {
        switch self.arrangement {
        case .S: self.generateTavernAreaArrangementS()
        case .M: self.generateTavernAreaArrangementM()
        case .L: self.generateTavernAreaArrangementL()
        case .XL: self.generateTavernAreaArrangementXL()
        }
    }
    
    private func addRootAndTipLocationsS() {
        self.addRootLocations(0)
        self.addTipLocations(2)
    }
    
    private func addRootAndTipLocationsM() {
        self.addRootLocations(0)
        self.addTipLocations(3)
    }
    
    private func addRootAndTipLocationsL() {
        self.addRootLocations(0)
        self.addTipLocations(4)
    }
    
    private func addRootAndTipLocationsXL() {
        self.addRootLocations(0)
        self.addTipLocations(5)
    }
    
    private func generateTavernAreaArrangementS() {
        self.locations[0].setHexagonCoordinate(5, 25)
        self.locations[1].setHexagonCoordinate(4, 26)
        self.locations[2].setHexagonCoordinate(5, 27)
        
        self.createUndirectedEdge(between: 0, and: 1)
        self.createUndirectedEdge(between: 0, and: 2)
        self.createUndirectedEdge(between: 1, and: 2)
    }
    
    private func generateTavernAreaArrangementM() {
        self.locations[0].setHexagonCoordinate(5, 25)
        self.locations[1].setHexagonCoordinate(4, 26)
        self.locations[2].setHexagonCoordinate(6, 26)
        self.locations[3].setHexagonCoordinate(5, 27)
        
        self.createUndirectedEdge(between: 0, and: 1)
        self.createUndirectedEdge(between: 0, and: 2)
        self.createUndirectedEdge(between: 1, and: 3)
        self.createUndirectedEdge(between: 2, and: 3)
    }
    
    private func generateTavernAreaArrangementL() {
        self.locations[0].setHexagonCoordinate(5, 25)
        self.locations[1].setHexagonCoordinate(4, 26)
        self.locations[2].setHexagonCoordinate(6, 26)
        self.locations[3].setHexagonCoordinate(5, 27)
        self.locations[4].setHexagonCoordinate(5, 29)
        
        self.createUndirectedEdge(between: 0, and: 1)
        self.createUndirectedEdge(between: 0, and: 2)
        self.createUndirectedEdge(between: 1, and: 3)
        self.createUndirectedEdge(between: 2, and: 3)
        self.createUndirectedEdge(between: 3, and: 4)
    }
    
    private func generateTavernAreaArrangementXL() {
        self.locations[0].setHexagonCoordinate(5, 25)
        self.locations[1].setHexagonCoordinate(4, 26)
        self.locations[2].setHexagonCoordinate(6, 26)
        self.locations[3].setHexagonCoordinate(4, 28)
        self.locations[4].setHexagonCoordinate(6, 28)
        self.locations[5].setHexagonCoordinate(5, 29)
        
        self.createUndirectedEdge(between: 0, and: 1)
        self.createUndirectedEdge(between: 0, and: 2)
        self.createUndirectedEdge(between: 1, and: 3)
        self.createUndirectedEdge(between: 2, and: 4)
        self.createUndirectedEdge(between: 3, and: 5)
        self.createUndirectedEdge(between: 4, and: 5)
    }
    
}
