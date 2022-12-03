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
    
    private let restoreOption: Restorer.RestoreOption
    private let restorerViewModel: RestorerViewModel
    private(set) var id: UUID
    
    var image: Image {
        switch self.restoreOption {
        case .health:
            return YonderIcons.healthIcon
        case .armorPoints:
            return YonderIcons.armorPointsIcon
        }
    }
    
    var actionDescription: String {
        switch self.restoreOption {
        case .health:
            return Strings("restoreOption.health.action").local
        case .armorPoints:
            return Strings("restoreOption.armor.action").local
        }
    }
    
    /// - Parameters:
    ///   - restoreOption: The restore option for purchase attached to this view model
    ///   - restorerViewModel: ViewModel of the restorer providing this restore option (and optionally others)
    init(restoreOption: Restorer.RestoreOption, restorerViewModel: RestorerViewModel) {
        self.restoreOption = restoreOption
        self.restorerViewModel = restorerViewModel
        
        self.id = restoreOption.id
    }
    
    func getBundlePrice() -> Int {
        let restorer = self.restorerViewModel.interactor as! Restorer
        return restorer.getBundlePrice(option: self.restoreOption)
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
    
    func restoreIsDisabled(playerViewModel: PlayerViewModel, amount: Int) -> Bool {
        let restorer = self.restorerViewModel.interactor as! Restorer
        if !restorer.canBeAfforded(by: playerViewModel.player, amount: amount, option: self.restoreOption) {
            return true
        }
        switch self.restoreOption {
        case .health:
            return playerViewModel.player.health >= playerViewModel.player.maxHealth
        case .armorPoints:
            return playerViewModel.player.armorPoints >= playerViewModel.player.maxArmorPoints
        }
    }
    
    func getIndicativeRestoration(of amount: Int, target: PlayerViewModel) -> Int {
        switch self.restoreOption {
        case .health:
            return BuffApps.getAppliedHealthRestoration(owner: NoActor(), using: NoItem(), target: target.player, healthRestoration: amount)
        case .armorPoints:
            return BuffApps.getAppliedArmorPointsRestoration(owner: NoActor(), using: NoItem(), target: target.player, armorPointsRestoration: amount)
        }
    }
    
}
