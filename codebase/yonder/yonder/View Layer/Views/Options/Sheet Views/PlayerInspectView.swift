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
            YonderText(text: "Your \(Term.stats.capitalized)", size: .inspectSheetTitle)
                
            InspectStatsBody {
                InspectStatView(title: Term.armorPoints.capitalized, value: self.playerViewModel.armorPoints, maxValue: self.playerViewModel.maxArmorPoints, image: YonderImages.armorPointsIcon)
                
                InspectStatView(title: Term.health.capitalized, value: self.playerViewModel.health, maxValue: self.playerViewModel.maxHealth, image: YonderImages.healthIcon)
                
                InspectStatView(title: Term.gold.capitalized, prefix: Term.currencySymbol, value: self.playerViewModel.gold, image: YonderImages.goldIcon)
            }
            
            InspectSectionSpacingView()
            
            YonderText(text: Term.buffsAndEffects.capitalized, size: .inspectSheetTitle)
        }
    }
}

struct PlayerInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            PlayerInspectView(playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: NoLocation())))
        }
    }
}
