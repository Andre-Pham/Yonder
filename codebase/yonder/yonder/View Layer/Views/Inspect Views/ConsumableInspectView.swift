//
//  ConsumableInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import SwiftUI

struct ConsumableInspectView: View {
    @ObservedObject var consumableViewModel: ConsumableViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: self.consumableViewModel.name, size: .inspectSheetTitle)
                
            InspectStatsBody {
                InspectStatView(title: Strings.Stat.Consumable.RemainingUses.local, value: self.consumableViewModel.stack, image: YonderImages.consumableRemainingUsesIcon)
            }
            
            if let effectsDescription = self.consumableViewModel.effectsDescription {
                YonderText(text: effectsDescription, size: .inspectSheetBody)
            }
            
            InspectSectionSpacingView()
            
            YonderText(text: self.consumableViewModel.description, size: .inspectSheetBody)
        }
    }
}

struct ConsumableInspectView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            ConsumableInspectView(consumableViewModel: PreviewObjects.consumableViewModel, playerViewModel: PreviewObjects.playerViewModel)
        }
    }
}
