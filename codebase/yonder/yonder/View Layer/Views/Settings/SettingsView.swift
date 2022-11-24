//
//  SettingsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

/// This is for temporary testing... this breaks so many rules
struct SettingsView: View {
    var body: some View {
        ScrollView {
            Group {
                Button("Damage Player 100") {
                    GameManager.instance.playerVM.player.damage(for: 100)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Travel") {
                    GameManager.instance.playerVM.player.travel(to: GameManager.instance.playerVM.player.location.nextLocations.first!)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Weapon") {
                    GameManager.instance.playerVM.player.addWeapon(Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5)))
                    GameManager.instance.playerVM.player.addWeapon(Weapon(basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: 50), durabilityPill: DecrementDurabilityPill(durability: 3)))
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Potion") {
                    GameManager.instance.playerVM.player.addPotion(HealthRestorationPotion(tier: .II, potionCount: 5))
                    GameManager.instance.playerVM.player.addPotion(DamagePotion(tier: .II, potionCount: 1))
                    GameManager.instance.playerVM.player.addPotion(DamagePercentBuffPotion(tier: .II, duration: 2, potionCount: 2))
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Armor") {
                    GameManager.instance.playerVM.player.equipArmor(Armors.newTestBodyArmor())
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Gold") {
                    GameManager.instance.playerVM.player.modifyGold(by: 200)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Buff") {
                    GameManager.instance.playerVM.player.addBuff(DamagePercentBuff(sourceName: "Magic", direction: .bidirectional, duration: 2, damageFraction: 1.5))
                    GameManager.instance.playerVM.player.addBuff(HealthRestorationPercentBuff(sourceName: "Magic Healing", direction: .incoming, duration: 2, healthFraction: 2.0))
                    GameManager.instance.playerVM.player.addBuff(PricePercentBuff(sourceName: "Fairy", duration: 1, priceFraction: 2.0))
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Status Effect") {
                    GameManager.instance.playerVM.player.addStatusEffect(BurnStatusEffect(damage: 15, duration: 2))
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Timed Event") {
                    GameManager.instance.playerVM.player.addTimedEvent(MaxHealthRestorationTimedEvent(timeToTrigger: 2))
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Accessory") {
                    GameManager.instance.playerVM.player.equipAccessory(Accessory(name: "Glasses", description: "Lets you see better.", type: .regular, healthBonus: 0, armorPointsBonus: 10, buffs: [PricePercentBuff(sourceName: "Glasses", duration: nil, priceFraction: 0.5)], equipmentPills: []), replacing: nil)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
            }
            
            Group {
                Button("Peripheral Accessory") {
                    GameManager.instance.playerVM.player.equipAccessory(Accessory(name: "Vampire Fang", description: "Sharp and bloody.", type: .peripheral, healthBonus: 0, armorPointsBonus: 0, buffs: [], equipmentPills: [WeaponLifestealEquipmentPill(lifestealFraction: 0.5, sourceName: "Vampire Fang")]), replacing: nil)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                
                Button("Consumables") {
                    GameManager.instance.playerVM.player.addConsumable(RandomHealthConsumable(amount: 1))
                    GameManager.instance.playerVM.player.addConsumable(MultiplyGoldConsumable(goldFraction: 2.0, amount: 1))
                    GameManager.instance.playerVM.player.addConsumable(BonusHealthConsumable(tier: .II, amount: 1))
                    GameManager.instance.playerVM.player.addConsumable(RipeningSetHealthConsumable(amount: 1))
                    GameManager.instance.playerVM.player.addConsumable(TravelImprovingRestorationConsumable(amount: 1))
                    GameManager.instance.playerVM.player.addConsumable(MaxRestoreAllConsumable(amount: 3))
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
