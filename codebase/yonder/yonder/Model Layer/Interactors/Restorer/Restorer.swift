//
//  Restorer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class Restorer: InteractorAbstract {
    
    enum RestoreOption {
        case health
        case armorPoints
        
        var id: UUID {
            switch self {
            case .health: return UUID(uuidString: "536F97B9-2C1C-493C-BE6E-759AFCE2D2C5")!
            case .armorPoints: return UUID(uuidString: "9B8E8B99-8687-4235-BC05-75E9136B551D")!
            }
        }
    }
    
    static let bundleSize = 10 // E.g. health is sold in bundles of 10
    public let options: [RestoreOption]
    public let pricePerHealthBundle: Int
    public let pricePerArmorPointBundle: Int
    
    init(name: String = "placeholderName", description: String = "placeholderDescription", options: [RestoreOption], pricePerHealthBundle: Int = 0, pricePerArmorPointBundle: Int = 0) {
        self.options = options
        self.pricePerHealthBundle = pricePerHealthBundle
        self.pricePerArmorPointBundle = pricePerArmorPointBundle
        
        super.init(name: name, description: description)
    }
    
    private func getPricePerUnit(option: RestoreOption) -> Double {
        let bundlePrice = Double(self.getBundlePrice(option: option))
        return bundlePrice/Double(Restorer.bundleSize)
    }
    
    private func getTotalCost(amount: Int, option: RestoreOption) -> Int {
        let bundlePrice = Double(self.getBundlePrice(option: option))
        let price = bundlePrice/Double(Restorer.bundleSize)
        return Int(round(Double(amount)*price))
    }
    
    func canBeAfforded(by player: Player, amount: Int, option: RestoreOption) -> Bool {
        let availableGold = player.gold
        let price = BuffApps.getAdjustedPrice(purchaser: player, price: Int(round(self.getPricePerUnit(option: option)*Double(amount))))
        return availableGold >= price
    }
    
    func getBundlePrice(option: RestoreOption) -> Int {
        switch option {
        case .health:
            return self.pricePerHealthBundle
        case .armorPoints:
            return self.pricePerArmorPointBundle
        }
    }
    
    func restoreHealth(to purchaser: Player, amount: Int) {
        guard self.canBeAfforded(by: purchaser, amount: amount, option: .health) else {
            return
        }
        guard !purchaser.isFullHealth else {
            return
        }
        purchaser.modifyGoldAdjusted(by: -self.getTotalCost(amount: amount, option: .health))
        purchaser.restoreHealthAdjusted(sourceOwner: Proxies.NO_ACTOR, using: Proxies.NO_ITEM, for: amount)
    }
    
    func restoreArmorPoints(to purchaser: Player, amount: Int) {
        guard self.canBeAfforded(by: purchaser, amount: amount, option: .armorPoints) else {
            return
        }
        guard !purchaser.isFullArmorPoints else {
            return
        }
        purchaser.modifyGoldAdjusted(by: -self.getTotalCost(amount: amount, option: .armorPoints))
        purchaser.restoreArmorPointsAdjusted(sourceOwner: Proxies.NO_ACTOR, using: Proxies.NO_ITEM, for: amount)
    }
    
}
