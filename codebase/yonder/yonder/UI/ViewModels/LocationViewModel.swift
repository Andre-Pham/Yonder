//
//  LocationViewModel.swift
//  yonder
//
//  Created by Andre Pham on 25/1/2022.
//

import Foundation
import Combine
import SwiftUI

class LocationViewModel: ObservableObject {
    
    private(set) var location: LocationAbstract
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var hasBeenVisited: Bool
    @Published private(set) var locationArrivedFrom: LocationAbstract?
    
    init(_ location: LocationAbstract) {
        self.location = location
        
        // Set properties to match Location
        
        self.hasBeenVisited = self.location.hasBeenVisited
        self.locationArrivedFrom = self.location.locationArrivedFrom
        
        // Add Subscribers
        
        self.location.$hasBeenVisited.sink(receiveValue: { newValue in
            self.hasBeenVisited = newValue
        }).store(in: &self.subscriptions)
        
        self.location.$locationArrivedFrom.sink(receiveValue: { newValue in
            self.locationArrivedFrom = newValue
        }).store(in: &self.subscriptions)
    }
    
}
