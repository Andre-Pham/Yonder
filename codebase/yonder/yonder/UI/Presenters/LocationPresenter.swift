//
//  LocationPresenter.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation
import Combine
import SwiftUI

class LocationPresenter: ObservableObject {
    
    @Published private(set) var location: LocationAbstract
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var name: String
    @Published private(set) var description: String
    @Published private(set) var image: Image
    @Published private(set) var type: String
    
    init(_ location: LocationAbstract) {
        self.location = location
        
        // MARK: Set properties to match location
        
        self.name = location.area.name
        self.description = location.area.description
        self.image = location.area.image
        self.type = "" // Must be initialised before function is called
        self.type = self.convertTypeToString(location.type)
        
        // MARK: Add Subscribers
        
        self.$location.sink(receiveValue: { newValue in
            self.location = newValue
            self.type = self.convertTypeToString(newValue.type)
            self.name = newValue.area.name
            self.description = newValue.area.description
            self.image = newValue.area.image
        }).store(in: &self.subscriptions)
    }
    
    func convertTypeToString(_ type: LocationType) -> String {
        switch type {
        case .none:
            return "None"
        case .boss:
            return "Boss"
        case .challengeHostile:
            return "Mini Boss"
        case .enhancer:
            return "Enhancer"
        case .friendly:
            return "Wanderer"
        case .hostile:
            return "Hostile"
        case .quest:
            return "Quest"
        case .restorer:
            return "Restorer"
        case .shop:
            return "Shop"
        }
    }
    
}
