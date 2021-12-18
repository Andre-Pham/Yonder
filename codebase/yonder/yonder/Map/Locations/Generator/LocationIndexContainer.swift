//
//  LocationIndexContainer.swift
//  yonder
//
//  Created by Andre Pham on 19/12/21.
//

import Foundation

class LocationIndexContainer {
    
    private(set) var indices = [Int]()
    public let type: LocationType
    public let sizeLimit: Int
    public var isFull: Bool {
        return indices.count == sizeLimit
    }
    
    init(sizeLimit: Int, type: LocationType) {
        self.sizeLimit = sizeLimit
        self.type = type
    }
    
    func addIndex(_ index: Int) {
        guard !self.isFull else {
            return
        }
        self.indices.append(index)
    }
    
}
