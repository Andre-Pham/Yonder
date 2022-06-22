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
                        
                        YonderText(text: " " + Strings.Stat.Damage.local, size: .buttonBodySubscript)
                    }
                }
                
                if self.weaponViewModel.healthRestoration > 0 {
                    YonderTextNumeralHStack {
                        YonderNumeral(number: self.weaponViewModel.healthRestoration, size: .buttonBodySubscript)
                        
                        YonderText(text: " " + Strings.Stat.HealthRestoration.local, size: .buttonBodySubscript)
                    }
                }
                
                YonderTextNumeralHStack {
                    YonderNumeral(number: self.weaponViewModel.remainingUses, size: .buttonBodySubscript)
                    
                    YonderText(text: " " + (self.weaponViewModel.remainingUses == 1 ? Strings.Stat.Weapon.RemainingUsesSingular.local : Strings.Stat.Weapon.RemainingUses.local), size: .buttonBodySubscript)
                }
            }
        } expandedContent: {
            YonderWideButton(text: Strings.Button.Use.local) {
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
