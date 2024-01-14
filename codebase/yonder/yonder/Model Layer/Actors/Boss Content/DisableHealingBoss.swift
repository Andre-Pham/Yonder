//
//  DisableHealingBoss.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2024.
//

import Foundation

class DisableHealingBoss: Foe, OnPlayerTravelSubscriber, AfterPlayerKillFoeSubscriber {
    
    private var disableHealingBuff: Buff
    
    init(contentID: String?, name: String, description: String, maxHealth: Int, damage: Int, lootChoice: LootChoice) {
        let buff = HealthRestorationPercentBuff(
            sourceName: Strings("boss.disableHealing.buffNamePrefix").local + name,
            direction: .incoming,
            duration: nil,
            healthFraction: 0.0
        )
        self.disableHealingBuff = buff
        
        super.init(
            contentID: contentID,
            name: name,
            description: description,
            maxHealth: maxHealth,
            weapon: BaseAttack(damage: damage),
            lootChoice: lootChoice
        )
        
        // The boss disables ALL healing, including for themself
        self.addBuff(buff)
        
        OnPlayerTravelPublisher.subscribe(self)
        AfterPlayerKillFoePublisher.subscribe(self)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case disableHealingBuff
    }

    required init(dataObject: DataObject) {
        self.disableHealingBuff = dataObject.getObjectOptional(Field.disableHealingBuff.rawValue, type: BuffAbstract.self) as! any Buff
        
        super.init(dataObject: dataObject)
        
        OnPlayerTravelPublisher.subscribe(self)
        AfterPlayerKillFoePublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.disableHealingBuff.rawValue, value: self.disableHealingBuff as BuffAbstract)
    }
    
    // MARK: - Functions
    
    override func initBossContent() {
        self.setBossContent(
            hint: Strings("boss.disableHealing.hint").local,
            description: Strings("boss.disableHealing.description").local
        )
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        guard newLocation.type == .boss else {
            return
        }
        guard let boss = (newLocation as? BossLocation)?.foe else {
            return
        }
        if boss.id == self.id {
            // The player is at this boss' location!
            player.addBuffByReference(self.disableHealingBuff)
        }
    }
    
    func afterPlayerKillFoe(player: Player, foe: Foe) {
        if foe.id == self.id {
            // The player killed this boss!
            player.removeBuff(self.disableHealingBuff)
        }
    }
    
}
