//
//  RestorerViewModel.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import Combine
import SwiftUI

class RestorerViewModel: InteractorViewModel {
    
    private(set) var options = [RestoreOptionViewModel]()
    
    init(_ restorer: Restorer) {
        super.init(restorer)
        
        for option in restorer.options {
            self.options.append(RestoreOptionViewModel(restoreOption: option, restorerViewModel: self))
        }
    }
    
}

class RestoreOptionViewModel: ObservableObject {
    
    private let restoreOption: RestoreOption
    private let restorerViewModel: RestorerViewModel
    //public let id = UUID()
    private(set) var id: UUID
    
    init(restoreOption: RestoreOption, restorerViewModel: RestorerViewModel) {
        self.restoreOption = restoreOption
        self.restorerViewModel = restorerViewModel
    }
    
    func getImage() -> Image {
        switch self.restoreOption {
        case .health:
            return YonderImages.healthIcon
        case .armorPoints:
            return YonderImages.armorPointsIcon
        }
    }
    
    func getPricePerUnit() -> Int {
        let restorer = self.restorerViewModel.interactor as! Restorer
        switch self.restoreOption {
        case .health:
            return restorer.pricePerHealth
        case .armorPoints:
            return restorer.pricePerArmorPoint
        }
    }
    
    func restore(amount: Int, to playerViewModel: PlayerViewModel) {
        let restorer = self.restorerViewModel.interactor as! Restorer
        switch self.restoreOption {
        case .health:
            restorer.restoreHealth(to: playerViewModel.player, amount: amount)
        case .armorPoints:
            restorer.restoreArmorPoints(to: playerViewModel.player, amount: amount)
        }
    }
    
}
