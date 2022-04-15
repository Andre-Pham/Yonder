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
    
    // Note: animation needs to be disabled when "use" isn't active, otherwise whenever the view updates, all buttons re-animate to their value
    var body: some View {
        YonderExpandableWideButtonBody(
            isExpanded: self.$useButtonActive,
            expandedButtonText: Term.use.capitalized) {
                self.playerViewModel.use(weaponViewModel: self.weaponViewModel)
        } label: {
            VStack(alignment: .leading) {
                YonderText(text: self.weaponViewModel.name, size: .buttonBody)
                    .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                
                if self.weaponViewModel.damage > 0 {
                    YonderTextAndNumeral(
                        format: [.numeral, .text],
                        text: [" " + Term.damage.capitalized],
                        numbers: [self.weaponViewModel.damage],
                        size: .buttonBodySubscript,
                        animationIsActive: self.useButtonActive)
                }
                
                if self.weaponViewModel.healthRestoration > 0 {
                    YonderTextAndNumeral(
                        format: [.numeral, .text],
                        text: [" " + Term.healthRestoration.capitalized],
                        numbers: [self.weaponViewModel.healthRestoration],
                        size: .buttonBodySubscript,
                        animationIsActive: self.useButtonActive)
                }
                
                YonderTextAndNumeral(
                    format: [.numeral, .text],
                    text: [" " + (self.weaponViewModel.remainingUses > 1 ? Term.remainingUses.capitalized : Term.remainingUse.capitalized)],
                    numbers: [self.weaponViewModel.remainingUses],
                    size: .buttonBodySubscript,
                    animationIsActive: self.useButtonActive)
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
