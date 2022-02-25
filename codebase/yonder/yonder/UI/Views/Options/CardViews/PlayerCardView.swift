//
//  PlayerCardView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct PlayerCardView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @State private var showingPlayerSheet = false
    
    var body: some View {
        CardBody(name: Term.player.capitalized) {
            CardRowView(
                value: self.playerViewModel.armorPoints,
                maxValue: self.playerViewModel.maxArmorPoints,
                image: YonderImages.shieldIcon)
            
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
            PlayerCardView(playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: NoLocation())))
        }
    }
}
