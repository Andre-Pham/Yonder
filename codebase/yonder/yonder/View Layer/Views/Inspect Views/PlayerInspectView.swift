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
            YonderText(text: Strings("inspect.title.playerStats").local, size: .inspectSheetTitle)
                
            InspectStatsBody {
                InspectStatView(
                    title: Strings("stat.shields").local,
                    value: self.playerViewModel.armorPoints,
                    maxValue: self.playerViewModel.maxArmorPoints,
                    image: YonderIcons.armorPointsIcon
                )
                
                InspectStatView(
                    title: Strings("stat.health").local,
                    value: self.playerViewModel.health,
                    maxValue: self.playerViewModel.maxHealth,
                    image: YonderIcons.healthIcon
                )
                
                InspectStatView(
                    title: Strings("stat.gold").local,
                    prefix: Strings("currencySymbol").local,
                    value: self.playerViewModel.gold,
                    image: YonderIcons.goldIcon
                )
            }
            
            InspectPlayerStatus(playerViewModel: self.playerViewModel)
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
