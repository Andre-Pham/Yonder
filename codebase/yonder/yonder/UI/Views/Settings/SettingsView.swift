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
            Text("Hello, Settings!")
            Button("Damage Player 100") {
                gameManager.playerVM.player.damage(for: 100)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Travel") {
                gameManager.playerVM.player.travel(to: gameManager.playerVM.player.location.nextLocations.first!)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Weapon") {
                gameManager.playerVM.player.addWeapon(Weapon(basePill: DamageBasePill(damage: 50, durability: 5), durabilityPill: DecrementDurabilityPill()))
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Potion") {
                gameManager.playerVM.player.addPotion(HealthRestorationPotion(name: "Cool Potion", description: "Lots of healing", healthRestoration: 100, potionCount: 5, basePurchasePrice: 100))
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Armor") {
                gameManager.playerVM.equipArmor(Armors.newTestBodyArmor())
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Gold") {
                gameManager.playerVM.player.modifyGold(by: 200)
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
