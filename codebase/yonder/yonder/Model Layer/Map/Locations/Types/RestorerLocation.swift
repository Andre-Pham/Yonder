//
//  RestorerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class RestorerLocation: Location {
    
    private(set) var restorer: Restorer
    public let type: LocationType = .restorer
    
    init(restorer: Restorer) {
        self.restorer = restorer
    }
    
}
