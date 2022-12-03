//
//  PlayerCardView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct PlayerCardView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    var resizeToFit: Bool = true
    
    var body: some View {
        CardBody(name: Strings("card.player.name").local,
                 resizeToFit: self.resizeToFit) {
            CardRowView(
                value: self.playerViewModel.armorPoints,
                maxValue: self.playerViewModel.maxArmorPoints,
                image: YonderIcons.armorPointsIcon)
            
            CardRowView(
                value: self.playerViewModel.health,
                maxValue: self.playerViewModel.maxHealth,
                image: YonderIcons.healthIcon)
            
            CardRowView(
                prefix: Strings("currencySymbol").local,
                value: self.playerViewModel.gold,
                image: YonderIcons.goldIcon)
        }
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            PlayerCardView(playerViewModel: PreviewObjects.playerViewModel)
        }
    }
}
