//
//  ItemInspectView.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2022.
//

import SwiftUI

struct ItemInspectView: View {
    var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: YonderCoreGraphics.paragraphSpacing) {
            YonderText(text: self.itemViewModel.name, size: .inspectSheetTitle)
                
            VStack(alignment: .leading, spacing: 6) {
                if self.itemViewModel.damage > 0 {
                    StatView(title: Term.damage.capitalized, value: self.itemViewModel.damage, image: YonderImages.itemDamageIcon)
                }
                
                if self.itemViewModel.healthRestoration > 0 {
                    StatView(title: Term.healthRestoration.capitalized, value: self.itemViewModel.healthRestoration, image: YonderImages.itemHealthRestorationIcon)
                }
                
                StatView(title: Term.remainingUses.capitalized, value: self.itemViewModel.remainingUses, image: YonderImages.durabilityIcon)
            }
            
            SectionSpacingView()
            
            YonderText(text: self.itemViewModel.description, size: .inspectSheetBody)
        }
    }
}

struct WeaponInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            ItemInspectView(itemViewModel: WeaponViewModel(Weapon(basePill: DamageBasePill(damage: 200, durability: 5), durabilityPill: DecrementDurabilityPill())))
        }
    }
}
