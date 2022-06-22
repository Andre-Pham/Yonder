//
//  PlayerInspectView.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2022.
//

import SwiftUI

struct PlayerInspectView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: Strings.Inspect.Title.PlayerStats.local, size: .inspectSheetTitle)
                
            InspectStatsBody {
                InspectStatView(title: Strings.Inspect.Stat.Shields.local, value: self.playerViewModel.armorPoints, maxValue: self.playerViewModel.maxArmorPoints, image: YonderImages.armorPointsIcon)
                
                InspectStatView(title: Strings.Inspect.Stat.Health.local, value: self.playerViewModel.health, maxValue: self.playerViewModel.maxHealth, image: YonderImages.healthIcon)
                
                InspectStatView(title: Strings.Inspect.Stat.Gold.local, prefix: Strings.CurrencySymbol.local, value: self.playerViewModel.gold, image: YonderImages.goldIcon)
            }
            
            InspectSectionSpacingView()
            
            YonderText(text: Strings.Inspect.Title.Buffs.local, size: .inspectSheetTitle)
            
            InspectSectionSpacingView()
            
            YonderText(text: Strings.Inspect.Title.StatusEffects.local, size: .inspectSheetTitle)
        }
    }
}

struct PlayerInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            PlayerInspectView(playerViewModel: PreviewObjects.playerViewModel)
        }
    }
}
