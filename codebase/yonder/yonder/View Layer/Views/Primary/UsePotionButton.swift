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
    private var isDisabled: Bool {
        return !self.playerViewModel.locationViewModel.playerCanEngage && self.potionViewModel.requiresFoeForUsage
    }
    
    var body: some View {
        YonderBorder4 {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    YonderText(text: self.potionViewModel.name, size: .buttonBody)
                        .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                    
                    if let effectsDescription = self.potionViewModel.effectsDescription {
                        if let foeViewModel = GameManager.instance.foeViewModel, self.potionViewModel.damage > 0 {
                                IndicativeEffectsDescriptionView(
                                    effectsDescription: effectsDescription,
                                    indicative: self.playerViewModel.getIndicativeDamage(itemViewModel: self.potionViewModel, opposition: foeViewModel),
                                    size: .buttonBodySubscript)
                        } else if self.potionViewModel.healthRestoration > 0 {
                            IndicativeEffectsDescriptionView(
                                effectsDescription: effectsDescription,
                                indicative: self.playerViewModel.getIndicativeHealthRestoration(of: self.potionViewModel),
                                size: .buttonBodySubscript)
                        } else if self.potionViewModel.armorPointsRestoration > 0 {
                            IndicativeEffectsDescriptionView(
                                effectsDescription: effectsDescription,
                                indicative: self.playerViewModel.getIndicativeArmorPointsRestoration(of: self.potionViewModel),
                                size: .buttonBodySubscript)
                        } else if self.potionViewModel.restoration > 0 {
                            YonderText(text: effectsDescription, size: .buttonBodySubscript)
                            
                            YonderText(text: self.playerViewModel.getIndicativeRestorationString(itemViewModel: self.potionViewModel), size: .buttonBodySubscript)
                        } else {
                            YonderText(text: effectsDescription, size: .buttonBodySubscript)
                        }
                    }
                    
                    YonderTextNumeralHStack {
                        YonderNumeral(number: self.potionViewModel.remainingUses, size: .buttonBodySubscript)
                        
                        YonderText(text: (self.potionViewModel.remainingUses == 1 ? Strings("stat.potion.remainingUsesSingular").local : Strings("stat.potion.remainingUses").local).leftPadded(by: " "), size: .buttonBodySubscript)
                    }
                    .padding(.top, YonderCoreGraphics.paragraphSpacing)
                }
                
                Spacer()
                
                Button {
                    self.playerViewModel.use(potionViewModel: self.potionViewModel)
                } label: {
                    YonderBorder10 {
                        YonderIcon(
                            image: YonderIcons.usePotionIcon,
                            sideLength: .large
                        )
                        .padding(10)
                    }
                }
                .disabledWhen(self.isDisabled)
            }
            .frame(maxWidth: .infinity)
            .padding(YonderCoreGraphics.innerPadding)
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
                potionViewModel: PreviewObjects.potionViewModel
            )
        }
    }
}
