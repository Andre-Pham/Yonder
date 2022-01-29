//
//  TravelStateManager.swift
//  yonder
//
//  Created by Andre Pham on 29/1/2022.
//

import Foundation
import SwiftUI

class TravelStateManager: ObservableObject {
    
    @Published private(set) var canTravel = false
    @Published private(set) var finishedTravelling = false
    
    func prepareForTravel() {
        self.canTravel = true
    }
    
    func travel() {
        self.canTravel = false
        self.finishedTravelling = true
    }
    
    func closeTravelOption() {
        self.canTravel = false
        self.finishedTravelling = false
    }
    
}
