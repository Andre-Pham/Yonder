//
//  HexagonCoordinate.swift
//  yonder
//
//  Created by Andre Pham on 16/12/21.
//

import Foundation

class HexagonCoordinate: Identifiable {
    
    public let x: Int
    public let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
}
