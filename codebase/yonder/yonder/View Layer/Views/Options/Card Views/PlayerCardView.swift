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
        CardBody(name: Term.player.capitalized,
                 resizeToFit: self.resizeToFit) {
            CardRowView(
                value: self.playerViewModel.armorPoints,
                maxValue: self.playerViewModel.maxArmorPoints,
                image: YonderImages.armorPointsIcon)
            
            CardRowView(
                value: self.playerViewModel.health,
                maxValue: self.playerViewModel.maxHealth,
                image: YonderImages.healthIcon)
            
            CardRowView(
                prefix: Term.currencySymbol,
                value: self.playerViewModel.gold,
                image: YonderImages.goldIcon)
        }
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            PlayerCardView(playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: NoLocation())))
        }
    }
}
