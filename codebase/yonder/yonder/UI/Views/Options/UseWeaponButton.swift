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
        ZStack(alignment: .bottom) {
            YonderWideButtonBody {
                self.useButtonActive.toggle()
            } label: {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            YonderText(text: self.weaponViewModel.name, size: .buttonBody)
                                .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                            
                            YonderText(text: "\(weaponViewModel.damage) \(Term.damage.capitalized)", size: .buttonBodySubscript)
                            
                            YonderText(text: "\(weaponViewModel.remainingUses) \(Term.remainingUses.capitalized)", size: .buttonBodySubscript)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, YonderCoreGraphics.padding)
                    
                    if self.useButtonActive {
                        // Expand button frame
                        YonderWideButton(text: "") {}
                        .padding(.top, YonderCoreGraphics.padding)
                        .hidden()
                    }
                }
            }
            if self.useButtonActive {
                YonderWideButton(text: "Use") {
                    self.playerViewModel.use(weaponViewModel: self.weaponViewModel)
                }
                .padding(.horizontal, YonderCoreGraphics.padding)
                .padding(.bottom, YonderCoreGraphics.padding)
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
