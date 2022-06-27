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
        VStack {
            Button("Damage Player 100") {
                GameManager.instance.playerVM.player.damage(for: 100)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Travel") {
                GameManager.instance.playerVM.player.travel(to: GameManager.instance.playerVM.player.location.nextLocations.first!)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Weapon") {
                GameManager.instance.playerVM.player.addWeapon(Weapon(basePill: DamageBasePill(damage: 50), durabilityPill: DecrementDurabilityPill(durability: 5)))
                GameManager.instance.playerVM.player.addWeapon(Weapon(basePill: ArmorPointsRestorationBasePill(armorPointsRestoration: 50), durabilityPill: DecrementDurabilityPill(durability: 3)))
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Potion") {
                GameManager.instance.playerVM.player.addPotion(HealthRestorationPotion(tier: .II, potionCount: 5, basePurchasePrice: 100))
                GameManager.instance.playerVM.player.addPotion(DamagePotion(tier: .II, potionCount: 1, basePurchasePrice: 10))
                GameManager.instance.playerVM.player.addPotion(DamagePercentPotion(tier: .II, duration: 2, potionCount: 2, basePurchasePrice: 100))
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Armor") {
                GameManager.instance.playerVM.equipArmor(Armors.newTestBodyArmor())
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Gold") {
                GameManager.instance.playerVM.player.modifyGold(by: 200)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Buff") {
                GameManager.instance.playerVM.player.addBuff(DamagePercentBuff(sourceName: "Magic", direction: .bidirectional, duration: 2, damageFraction: 1.5))
                GameManager.instance.playerVM.player.addBuff(HealthRestorationPercentBuff(sourceName: "Magic Healing", direction: .incoming, duration: 2, healthFraction: 2.0))
                GameManager.instance.playerVM.player.addBuff(PricePercentBuff(sourceName: "Fairy", direction: .outgoing, duration: 1, priceFraction: 2.0))
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
