//
//  ItemInspectView.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2022.
//

import SwiftUI

struct ItemInspectView: View {
    @ObservedObject var itemViewModel: ItemViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: self.itemViewModel.name, size: .inspectSheetTitle)
                
            InspectStatsBody {
                if self.itemViewModel.damage > 0 {
                    InspectStatView(title: Strings.Stat.Damage.local, value: self.itemViewModel.damage, image: self.itemViewModel.damageImage)
                }
                
                if self.itemViewModel.healthRestoration > 0 {
                    InspectStatView(title: Strings.Stat.HealthRestoration.local, value: self.itemViewModel.healthRestoration, image: self.itemViewModel.healthRestorationImage)
                }
                
                if self.itemViewModel.infiniteRemainingUses {
                    InspectStatusView(title: self.itemViewModel.remainingUsesDescription, status: Strings.Item.Infinite.local, image: self.itemViewModel.remainingUsesImage)
                } else {
                    InspectStatView(title: self.itemViewModel.remainingUsesDescription, value: self.itemViewModel.remainingUses, image: self.itemViewModel.remainingUsesImage)
                }
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
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ItemInspectView(itemViewModel: PreviewObjects.weaponViewModel)
                .padding()
        }
        
        ZStack(alignment: .topLeading) {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ItemInspectView(itemViewModel: PreviewObjects.potionViewModel)
                .padding()
        }
    }
}
