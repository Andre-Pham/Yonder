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
        YonderBorder4 {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    YonderText(text: self.weaponViewModel.name, size: .buttonBody)
                        .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                    
                    StatsStack {
                        if self.weaponViewModel.damage > 0 {
                            if let foeViewModel = GameManager.instance.foeViewModel {
                                StatView(
                                    title: Strings("stat.damage").local,
                                    value: self.weaponViewModel.damage,
                                    indicativeValue: self.playerViewModel.getIndicativeDamage(
                                        itemViewModel: self.weaponViewModel,
                                        opposition: foeViewModel
                                    ),
                                    image: self.weaponViewModel.damageImage
                                )
                            } else {
                                StatView(
                                    title: Strings("stat.damage").local,
                                    value: self.weaponViewModel.damage,
                                    indicativeValue: self.playerViewModel.getPassiveIndicativeDamage(
                                        itemViewModel: self.weaponViewModel
                                    ),
                                    image: self.weaponViewModel.damageImage
                                )
                            }
                        }

                        if self.weaponViewModel.healthRestoration > 0 {
                            StatView(
                                title: Strings("stat.healthRestoration").local,
                                value: self.weaponViewModel.healthRestoration,
                                indicativeValue: self.playerViewModel.getIndicativeHealthRestoration(
                                    of: self.weaponViewModel
                                ),
                                image: self.weaponViewModel.healthRestorationImage
                            )
                        }

                        if self.weaponViewModel.armorPointsRestoration > 0 {
                            StatView(
                                title: Strings("stat.armorPointsRestoration").local,
                                value: self.weaponViewModel.armorPointsRestoration,
                                indicativeValue: self.playerViewModel.getIndicativeArmorPointsRestoration(
                                    of: self.weaponViewModel
                                ),
                                image: self.weaponViewModel.armorPointsRestorationImage
                            )
                        }

                        if self.weaponViewModel.restoration > 0 {
                            StatView(
                                title: Strings("stat.restoration").local,
                                value: self.weaponViewModel.restoration,
                                indicativeValue: self.playerViewModel.getIndicativeRestoration(
                                    of: self.weaponViewModel
                                ),
                                image: self.weaponViewModel.restorationImage
                            )
                        }

                        if let effectsDescription = self.weaponViewModel.previewEffectsDescription {
                            YonderText(text: effectsDescription, size: .buttonBodySubscript)
                                .padding(.bottom, YonderCoreGraphics.paragraphSpacing)
                        }
                        
                        if self.weaponViewModel.infiniteRemainingUses {
                            YonderText(
                                text: Strings("item.infinite").local
                                    .continuedBy(Strings("stat.weapon.remainingUses").local),
                                size: .buttonBodySubscript
                            )
                        } else {
                            StatView(
                                title: (self.weaponViewModel.remainingUses == 1 ? Strings("stat.weapon.remainingUsesSingular").local : Strings("stat.weapon.remainingUses").local),
                                value: self.weaponViewModel.remainingUses,
                                image: self.weaponViewModel.remainingUsesImage
                            )
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    self.playerViewModel.use(weaponViewModel: self.weaponViewModel)
                } label: {
                    YonderBorder9 {
                        YonderIcon(
                            image: YonderIcons.useWeaponIcon,
                            sideLength: .large
                        )
                        .padding(10)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(YonderCoreGraphics.innerPadding)
        }
    }
}

struct UseWeaponButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            UseWeaponButton(
                playerViewModel: PreviewObjects.playerViewModel,
                weaponViewModel: PreviewObjects.weaponViewModel
            )
        }
    }
}
