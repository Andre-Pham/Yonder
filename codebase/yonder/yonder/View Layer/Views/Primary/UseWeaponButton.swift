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
                        if let foeViewModel = GameManager.instance.foeViewModel {
                            IndicativeNumeralView(
                                original: self.weaponViewModel.damage,
                                indicative: self.playerViewModel.getIndicativeDamage(itemViewModel: self.weaponViewModel, opposition: foeViewModel),
                                size: .buttonBodySubscript)
                        } else {
                            YonderNumeral(number: self.weaponViewModel.damage, size: .buttonBodySubscript)
                        }
                        
                        YonderText(text: Strings("stat.damage").local.leftPadded(by: " "), size: .buttonBodySubscript)
                    }
                }
                
                if self.weaponViewModel.restoration > 0 {
                    YonderTextNumeralHStack {
                        YonderNumeral(number: self.weaponViewModel.restoration, size: .buttonBodySubscript)
                        
                        YonderText(text: Strings("stat.restoration").local.leftPadded(by: " "), size: .buttonBodySubscript)
                    }
                    
                    YonderText(text: self.playerViewModel.getIndicativeRestorationString(itemViewModel: self.weaponViewModel), size: .buttonBodySubscript)
                }
                
                if self.weaponViewModel.healthRestoration > 0 {
                    YonderTextNumeralHStack {
                        IndicativeNumeralView(
                            original: self.weaponViewModel.healthRestoration,
                            indicative: self.playerViewModel.getIndicativeHealthRestoration(of: self.weaponViewModel),
                            size: .buttonBodySubscript)
                        
                        YonderText(text: Strings("stat.healthRestoration").local.leftPadded(by: " "), size: .buttonBodySubscript)
                    }
                }
                
                if self.weaponViewModel.armorPointsRestoration > 0 {
                    YonderTextNumeralHStack {
                        IndicativeNumeralView(
                            original: self.weaponViewModel.armorPointsRestoration,
                            indicative: self.playerViewModel.getIndicativeArmorPointsRestoration(of: self.weaponViewModel),
                            size: .buttonBodySubscript)
                        
                        YonderText(text: Strings("stat.armorPointsRestoration").local.leftPadded(by: " "), size: .buttonBodySubscript)
                    }
                }
                
                if let effectsDescription = self.weaponViewModel.previewEffectsDescription {
                    YonderText(text: effectsDescription, size: .buttonBodySubscript)
                }
                
                YonderTextNumeralHStack {
                    if self.weaponViewModel.infiniteRemainingUses {
                        YonderText(text: Strings("item.infinite").local, size: .buttonBodySubscript)
                    } else {
                        YonderNumeral(number: self.weaponViewModel.remainingUses, size: .buttonBodySubscript)
                    }
                    
                    YonderText(text: (self.weaponViewModel.remainingUses == 1 ? Strings("stat.weapon.remainingUsesSingular").local : Strings("stat.weapon.remainingUses").local).leftPadded(by: " "), size: .buttonBodySubscript)
                }
            }
        } expandedContent: {
            YonderWideButton(text: Strings("button.use").local) {
                self.playerViewModel.use(weaponViewModel: self.weaponViewModel)
            }
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
                weaponViewModel: PreviewObjects.weaponViewModel)
        }
    }
}
