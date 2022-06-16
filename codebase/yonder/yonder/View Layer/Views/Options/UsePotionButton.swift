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
        YonderExpandableWideButtonBody(isExpanded: self.$useButtonActive) {
            VStack(alignment: .leading) {
                YonderText(text: self.potionViewModel.name, size: .buttonBody)
                    .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                
                YonderText(text: self.potionViewModel.description, size: .buttonBodySubscript)
                
                YonderTextNumeralHStack {
                    YonderNumeral(number: self.potionViewModel.remainingUses, size: .buttonBodySubscript)
                    
                    YonderText(text: " " + (self.potionViewModel.remainingUses > 1 ? Term.potions.capitalized : Term.potion.capitalized), size: .buttonBodySubscript)
                }
            }
        } expandedContent: {
            YonderWideButton(text: Term.instantUse.capitalized) {
                self.playerViewModel.use(potionViewModel: self.potionViewModel)
            }
        }
    }
}

struct UsePotionButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            UsePotionButton(
                playerViewModel: PreviewObjects.playerViewModel,
                potionViewModel: PreviewObjects.potionViewModel)
        }
    }
}
