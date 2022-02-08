//
//  SettingsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Hello, Settings!")
            Button("Damage Player 100") {
                GAME.player.damage(for: 100)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Travel") {
                GAME.player.travel(to: GAME.player.location.nextLocations.first!)
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .padding()
            
            Button("Weapon") {
                GAME.player.addWeapon(BasicWeapon(damage: 50, durability: 5, basePurchasePrice: 5))
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
