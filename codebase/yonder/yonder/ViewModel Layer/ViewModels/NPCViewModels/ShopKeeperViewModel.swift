//
//  ShopKeeperViewModel.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import Combine

class ShopKeeperViewModel: InteractorViewModel {
    
    @Published private(set) var purchasables = [PurchasableViewModel]()
    
    init(_ shopKeeper: ShopKeeper) {
        super.init(shopKeeper)
        
        for purchasable in shopKeeper.purchasableItems {
            self.purchasables.append(PurchasableViewModel(purchasable: purchasable, shopKeeperViewModel: self))
        }
    }
    
}

class PurchasableViewModel: ObservableObject {
    
    private let purchasable: PurchasableItem
    private let shopKeeperViewModel: ShopKeeperViewModel
    private var subscriptions: Set<AnyCancellable> = []
    public let name: String
    private(set) var id: UUID
    public let price: Int
    @Published private(set) var stockRemaining: Int
    
    init(purchasable: PurchasableItem, shopKeeperViewModel: ShopKeeperViewModel) {
        self.purchasable = purchasable
        self.shopKeeperViewModel = shopKeeperViewModel
        
        self.name = purchasable.info.name
        self.id = purchasable.id
        self.price = purchasable.price
        self.stockRemaining = purchasable.stockRemaining
        
        self.purchasable.$stockRemaining.sink(receiveValue: { newValue in
            self.stockRemaining = newValue
        }).store(in: &self.subscriptions)
    }
    
    func purchase(by playerViewModel: PlayerViewModel, amount: Int) {
        (self.shopKeeperViewModel.interactor as! ShopKeeper).purchaseItem(self.purchasable, amount: amount, purchaser: playerViewModel.player)
    }
    
    func purchaseIsDisabled(for playerViewModel: PlayerViewModel, amount: Int) -> Bool {
        return !self.purchasable.canPurchase(amount: amount, purchaser: playerViewModel.player)
    }
    
    func getItemViewModel() -> ItemViewModel? {
        switch self.purchasable.info.type {
        case .weapon:
            return WeaponViewModel(self.purchasable.item as! Weapon)
        case .potion:
            return PotionViewModel(self.purchasable.item as! PotionAbstract)
        case .armor:
            return nil
        }
    }
    
    func getArmorViewModel() -> ArmorViewModel? {
        if self.purchasable.info.type == .armor {
            return ArmorViewModel(self.purchasable.item as! ArmorAbstract)
        }
        return nil
    }
    
    func getNameAndDescription() -> (String, String) {
        return (self.purchasable.info.name, self.purchasable.info.description)
    }
    
}
