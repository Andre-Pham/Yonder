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
                    
                    StatsStack {
                        if self.potionViewModel.damage > 0 {
                            if let foeViewModel = GameManager.instance.foeViewModel {
                                StatView(
                                    title: Strings("stat.damage").local,
                                    value: self.potionViewModel.damage,
                                    indicativeValue: self.playerViewModel.getIndicativeDamage(
                                        itemViewModel: self.potionViewModel,
                                        opposition: foeViewModel
                                    ),
                                    image: self.potionViewModel.damageImage
                                )
                            } else {
                                StatView(
                                    title: Strings("stat.damage").local,
                                    value: self.potionViewModel.damage,
                                    indicativeValue: self.playerViewModel.getPassiveIndicativeDamage(
                                        itemViewModel: self.potionViewModel
                                    ),
                                    image: self.potionViewModel.damageImage
                                )
                            }
                        }
                        
                        if self.potionViewModel.healthRestoration > 0 {
                            StatView(
                                title: Strings("stat.healthRestoration").local,
                                value: self.potionViewModel.healthRestoration,
                                indicativeValue: self.playerViewModel.getIndicativeHealthRestoration(
                                    of: self.potionViewModel
                                ),
                                image: self.potionViewModel.healthRestorationImage
                            )
                        }
                        
                        if self.potionViewModel.armorPointsRestoration > 0 {
                            StatView(
                                title: Strings("stat.armorPointsRestoration").local,
                                value: self.potionViewModel.armorPointsRestoration,
                                indicativeValue: self.playerViewModel.getIndicativeArmorPointsRestoration(
                                    of: self.potionViewModel
                                ),
                                image: self.potionViewModel.armorPointsRestorationImage
                            )
                        }
                        
                        if self.potionViewModel.restoration > 0 {
                            StatView(
                                title: Strings("stat.restoration").local,
                                value: self.potionViewModel.restoration,
                                indicativeValue: self.playerViewModel.getIndicativeRestoration(
                                    of: self.potionViewModel
                                ),
                                image: self.potionViewModel.restorationImage
                            )
                        }
                        
                        if let effectsDescription = self.potionViewModel.effectsDescription {
                            YonderText(text: effectsDescription, size: .buttonBodySubscript)
                                .padding(.bottom, YonderCoreGraphics.paragraphSpacing)
                        }
                        
                        StatView(
                            title: (self.potionViewModel.remainingUses == 1 ? Strings("stat.potion.remainingUsesSingular").local : Strings("stat.potion.remainingUses").local),
                            value: self.potionViewModel.remainingUses,
                            image: self.potionViewModel.remainingUsesImage
                        )
                    }
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

#Preview {
    PreviewContentView {
        UsePotionButton(
            playerViewModel: PreviewObjects.playerViewModel,
            potionViewModel: PreviewObjects.potionViewModel
        )
    }
}
