//
//  UseWeaponButton.swift
//  yonder
//
//  Created by Andre Pham on 21/2/2022.
//

import SwiftUI

struct UseWeaponButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var weaponViewModel: WeaponViewModel
    @State private var useButtonActive = false
    
    var body: some View {
        YonderExpandableWideButtonBody(isExpanded: self.$useButtonActive) {
            VStack(alignment: .leading) {
                YonderText(text: self.weaponViewModel.name, size: .buttonBody)
                    .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                
                if self.weaponViewModel.damage > 0 {
                    YonderTextNumeralHStack {
                        YonderNumeral(number: self.weaponViewModel.damage, size: .buttonBodySubscript)
                        
                        YonderText(text: " " + Term.damage.capitalized, size: .buttonBodySubscript)
                    }
                }
                
                if self.weaponViewModel.healthRestoration > 0 {
                    YonderTextNumeralHStack {
                        YonderNumeral(number: self.weaponViewModel.healthRestoration, size: .buttonBodySubscript)
                        
                        YonderText(text: " " + Term.healthRestoration.capitalized, size: .buttonBodySubscript)
                    }
                }
                
                YonderTextNumeralHStack {
                    YonderNumeral(number: self.weaponViewModel.remainingUses, size: .buttonBodySubscript)
                    
                    YonderText(text: " " + (self.weaponViewModel.remainingUses > 1 ? Term.remainingUses.capitalized : Term.remainingUse.capitalized), size: .buttonBodySubscript)
                }
            }
        } expandedContent: {
            YonderWideButton(text: Term.use.capitalized) {
                self.playerViewModel.use(weaponViewModel: self.weaponViewModel)
            }
        }
    }
}

struct UseWeaponButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            UseWeaponButton(
                playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: FriendlyLocation(friendly: Friendly(offers: [], offerLimit: 0)))),
                weaponViewModel: WeaponViewModel(Weapon(
                    basePill: DamageBasePill(damage: 50, durability: 5),
                    durabilityPill: DecrementDurabilityPill()
            )))
        }
    }
}
