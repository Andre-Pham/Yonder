//
//  ItemInspectView.swift
//  yonder
//
//  Created by Andre Pham on 24/3/2022.
//

import SwiftUI

struct ItemInspectView: View {
    @ObservedObject var itemViewModel: ItemViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: self.itemViewModel.name, size: .inspectSheetTitle)
                
            InspectStatsBody {
                if self.itemViewModel.damage > 0 {
                    if let foeViewModel = GameManager.instance.foeViewModel {
                        InspectStatView(title: Strings("stat.damage").local, value: self.itemViewModel.damage, indicativeValue: self.playerViewModel.getIndicativeDamage(itemViewModel: self.itemViewModel, opposition: foeViewModel), image: self.itemViewModel.damageImage)
                    } else {
                        InspectStatView(title: Strings("stat.damage").local, value: self.itemViewModel.damage, indicativeValue: self.playerViewModel.getPassiveIndicativeDamage(itemViewModel: self.itemViewModel), image: self.itemViewModel.damageImage)
                    }
                }
                
                if self.itemViewModel.restoration > 0 {
                    InspectStatView(title: Strings("stat.restoration").local, value: self.itemViewModel.restoration, image: self.itemViewModel.restorationImage)
                    
                    YonderText(text: self.playerViewModel.getIndicativeRestorationString(itemViewModel: self.itemViewModel), size: .inspectSheetBody)
                }
                
                if self.itemViewModel.healthRestoration > 0 {
                    InspectStatView(title: Strings("stat.healthRestoration").local, value: self.itemViewModel.healthRestoration, indicativeValue: self.playerViewModel.getIndicativeHealthRestoration(of: self.itemViewModel), image: self.itemViewModel.healthRestorationImage)
                }
                
                if self.itemViewModel.armorPointsRestoration > 0 {
                    InspectStatView(title: Strings("stat.armorPointsRestoration").local, value: self.itemViewModel.armorPointsRestoration, indicativeValue: self.playerViewModel.getIndicativeArmorPointsRestoration(of: self.itemViewModel), image: self.itemViewModel.armorPointsRestorationImage)
                }
                
                if self.itemViewModel.infiniteRemainingUses {
                    InspectStatusView(title: self.itemViewModel.remainingUsesDescription, status: Strings("item.infinite").local, image: self.itemViewModel.remainingUsesImage)
                } else {
                    InspectStatView(title: self.itemViewModel.remainingUsesDescription, value: self.itemViewModel.remainingUses, image: self.itemViewModel.remainingUsesImage)
                }
            }
            
            if let effectsDescription = self.itemViewModel.effectsDescription {
                YonderText(text: effectsDescription, size: .inspectSheetBody)
            }
            
            if self.itemViewModel.requiresFoeForUsage {
                YonderText(text: Strings("item.requiresCombat").local, size: .inspectSheetBody)
            }
            
            InspectSectionSpacingView()
            
            if !self.itemViewModel.description.isEmpty {
                YonderText(text: self.itemViewModel.description, size: .inspectSheetBody)
            }
        }
    }
}

struct ItemInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .topLeading) {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ItemInspectView(itemViewModel: PreviewObjects.weaponViewModel, playerViewModel: PreviewObjects.playerViewModel)
                .padding()
        }
        
        ZStack(alignment: .topLeading) {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ItemInspectView(itemViewModel: PreviewObjects.potionViewModel, playerViewModel: PreviewObjects.playerViewModel)
                .padding()
        }
        
        ZStack(alignment: .topLeading) {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ItemInspectView(itemViewModel: PreviewObjects.consumableViewModel, playerViewModel: PreviewObjects.playerViewModel)
                .padding()
        }
    }
}
