//
//  ItemInspectView.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2022.
//

import SwiftUI

struct ItemInspectView: View {
    @ObservedObject var itemViewModel: ItemViewModel
    var remainingUsesDescription: String {
        switch itemViewModel {
        case is WeaponViewModel:
            return Term.weaponRemainingUses.capitalized
        case is PotionViewModel:
            return Term.potionRemainingUses.capitalized
        default:
            return Term.remainingUses.capitalized
        }
    }
    
    var body: some View {
        InspectBody {
            YonderText(text: self.itemViewModel.name, size: .inspectSheetTitle)
                
            InspectStatsBody {
                if self.itemViewModel.damage > 0 {
                    InspectStatView(title: Term.damage.capitalized, value: self.itemViewModel.damage, image: YonderImages.itemDamageIcon)
                }
                
                if self.itemViewModel.healthRestoration > 0 {
                    InspectStatView(title: Term.healthRestoration.capitalized, value: self.itemViewModel.healthRestoration, image: YonderImages.itemHealthRestorationIcon)
                }
                
                InspectStatView(title: self.remainingUsesDescription, value: self.itemViewModel.remainingUses, image: YonderImages.durabilityIcon)
            }
            
            if let effectsDescription = self.itemViewModel.effectsDescription {
                YonderText(text: effectsDescription, size: .inspectSheetBody)
            }
            
            InspectSectionSpacingView()
            
            YonderText(text: self.itemViewModel.description, size: .inspectSheetBody)
        }
    }
}

struct ItemInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .topLeading) {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            ItemInspectView(itemViewModel: WeaponViewModel(Weapon(basePill: DamageBasePill(damage: 200, durability: 5), durabilityPill: DecrementDurabilityPill())))
                .padding()
        }
    }
}
