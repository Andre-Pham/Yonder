//
//  AccessoryInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/7/2022.
//

import SwiftUI

struct AccessoryInspectView: View {
    @ObservedObject var accessoryViewModel: AccessoryViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: self.accessoryViewModel.name, size: .inspectSheetTitle)
            
            InspectTagView(tag: self.accessoryViewModel.inspectTag)
            
            InspectSectionSpacingView()
            
            if !self.accessoryViewModel.noStats {
                InspectStatsBody {
                    if self.accessoryViewModel.healthBonus > 0 {
                        InspectStatView(title: Strings("stat.healthBonus").local, value: self.accessoryViewModel.healthBonus, image: YonderIcons.healthBonusIcon)
                    }
                    
                    if self.accessoryViewModel.armorPointsBonus > 0 {
                        InspectStatView(title: Strings("stat.armorPointsBonus").local, value: self.accessoryViewModel.armorPointsBonus, image: YonderIcons.armorPointsIcon)
                    }
                }
            }
            
            if let effectsDescription = self.accessoryViewModel.effectsDescription {
                YonderText(text: effectsDescription, size: .inspectSheetBody)
            }
        }
    }
}

struct AccessoryInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            AccessoryInspectView(accessoryViewModel: PreviewObjects.accessoryViewModel)
        }
        
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            AccessoryInspectView(accessoryViewModel: PreviewObjects.peripheralAccessoryViewModel)
        }
    }
}
