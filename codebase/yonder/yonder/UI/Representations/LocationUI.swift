//
//  LocationUI.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation

class LocationUI: ObservableObject {
    
    private(set) var location: LocationAbstract
    
    init(_ location: LocationAbstract) {
        self.location = location
    }
    
}
