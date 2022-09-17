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
    
    func getOffersDescription() -> String {
        let separator = "\n\(Strings.DotPoint.local) "
        var description = ""
        var purchasablesTypes = self.purchasables.map { $0.type }
        purchasablesTypes = Array(Set(purchasablesTypes)) // Filter duplicaates
        for type in purchasablesTypes {
            if !description.isEmpty {
                description += separator
            }
            description += type.categoryDescription
        }
        return separator + description
    }
    
    func getHighestPrice() -> Int {
        return self.purchasables.sorted { $0.price > $1.price }.first?.price ?? 0
    }
    
    func getLowestPrice() -> Int {
        return self.purchasables.sorted { $0.price < $1.price }.first?.price ?? 0
    }
    
}

class PurchasableViewModel: ObservableObject {
    
    private let purchasable: PurchasableItem
    private let shopKeeperViewModel: ShopKeeperViewModel
    private var subscriptions: Set<AnyCancellable> = []
    public let name: String
    private(set) var id: UUID
    public let price: Int
    public let type: PurchasableItem.PurchasableItemType
    @Published private(set) var stockRemaining: Int
    
    init(purchasable: PurchasableItem, shopKeeperViewModel: ShopKeeperViewModel) {
        self.purchasable = purchasable
        self.shopKeeperViewModel = shopKeeperViewModel
        
        self.name = purchasable.info.name
        self.id = purchasable.id
        self.price = purchasable.price
        self.type = purchasable.info.type
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
            return PotionViewModel(self.purchasable.item as! Potion)
        case .armor:
            return nil
        case .accessory:
            return nil
        case .consumable:
            return nil
        }
    }
    
    func getArmorViewModel() -> ArmorViewModel? {
        if self.purchasable.info.type == .armor {
            return ArmorViewModel(self.purchasable.item as! Armor)
        }
        return nil
    }
    
    func getAccessoryViewModel() -> AccessoryViewModel? {
        if self.purchasable.info.type == .accessory {
            return AccessoryViewModel(self.purchasable.item as! Accessory)
        }
        return nil
    }
    
    func getNameAndDescription() -> (String, String) {
        return (self.purchasable.info.name, self.purchasable.info.description)
    }
    
}
