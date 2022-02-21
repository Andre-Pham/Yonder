//
//  UsePotionButton.swift
//  yonder
//
//  Created by Andre Pham on 21/2/2022.
//

import SwiftUI

struct UsePotionButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var potionViewModel: PotionViewModel
    @State private var useButtonActive = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            YonderWideButtonBody {
                self.useButtonActive.toggle()
            } label: {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            YonderText(text: self.potionViewModel.name, size: .buttonBody)
                                .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                            
                            YonderText(text: self.potionViewModel.description, size: .buttonBodySubscript)
                            
                            YonderText(text: "\(self.potionViewModel.remainingUses) \(self.potionViewModel.remainingUses > 1 ? Term.potions.capitalized : Term.potion.capitalized) Left", size: .buttonBodySubscript)
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
                YonderWideButton(text: Term.quickUse.capitalized) {
                    self.playerViewModel.use(potionViewModel: self.potionViewModel)
                }
                .padding(.horizontal, YonderCoreGraphics.padding)
                .padding(.bottom, YonderCoreGraphics.padding)
            }
        }
    }
}

struct UsePotionButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            UsePotionButton(
                playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: FriendlyLocation(friendly: Friendly(offers: [], offerLimit: 0)))),
                potionViewModel: PotionViewModel(DamagePotion(damage: 50, potionCount: 3, basePurchasePrice: 100)))
        }
    }
}
