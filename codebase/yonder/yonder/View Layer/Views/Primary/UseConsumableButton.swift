//
//  UseConsumableButton.swift
//  yonder
//
//  Created by Andre Pham on 14/9/2022.
//

import SwiftUI

struct UseConsumableButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var consumableViewModel: ConsumableViewModel
    @State private var useButtonActive = false
    
    var body: some View {
        YonderExpandableWideButtonBody(isExpanded: self.$useButtonActive) {
            VStack(alignment: .leading) {
                YonderText(text: self.consumableViewModel.name, size: .buttonBody)
                    .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                
                if let effectsDescription = self.consumableViewModel.effectsDescription {
                    if let foeViewModel = GameManager.instance.foeViewModel, self.consumableViewModel.damage > 0 {
                            IndicativeEffectsDescriptionView(
                                effectsDescription: effectsDescription,
                                indicative: self.playerViewModel.getIndicativeDamage(itemViewModel: self.consumableViewModel, opposition: foeViewModel),
                                size: .buttonBodySubscript)
                    } else if self.consumableViewModel.healthRestoration > 0 {
                        IndicativeEffectsDescriptionView(
                            effectsDescription: effectsDescription,
                            indicative: self.playerViewModel.getIndicativeHealthRestoration(of: self.consumableViewModel),
                            size: .buttonBodySubscript)
                    } else if self.consumableViewModel.armorPointsRestoration > 0 {
                        IndicativeEffectsDescriptionView(
                            effectsDescription: effectsDescription,
                            indicative: self.playerViewModel.getIndicativeArmorPointsRestoration(of: self.consumableViewModel),
                            size: .buttonBodySubscript)
                    } else if self.consumableViewModel.restoration > 0 {
                        YonderText(text: effectsDescription, size: .buttonBodySubscript)
                        
                        YonderText(text: self.playerViewModel.getIndicativeRestorationString(itemViewModel: self.consumableViewModel), size: .buttonBodySubscript)
                    } else {
                        YonderText(text: effectsDescription, size: .buttonBodySubscript)
                    }
                }
                
                YonderTextNumeralHStack {
                    YonderNumeral(number: self.consumableViewModel.remainingUses, size: .buttonBodySubscript)
                    
                    YonderText(text: Strings.Stat.Consumable.Remaining.local.leftPadded(by: " "), size: .buttonBodySubscript)
                }
                .padding(.top, YonderCoreGraphics.paragraphSpacing)
            }
        } expandedContent: {
            YonderWideButton(text: Strings.Button.InstantUse.local) {
                self.playerViewModel.use(consumableViewModel: self.consumableViewModel)
            }
            .disabledWhen(self.playerViewModel.locationViewModel.getFoeViewModel() == nil && self.consumableViewModel.requiresFoeForUsage)
        }
    }
}

struct UseConsumableButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            UseConsumableButton(playerViewModel: PreviewObjects.playerViewModel, consumableViewModel: PreviewObjects.consumableViewModel)
        }
    }
}