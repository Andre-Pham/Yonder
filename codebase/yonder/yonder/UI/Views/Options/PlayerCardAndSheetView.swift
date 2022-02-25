//
//  PlayerCardAndSheetView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import SwiftUI

struct PlayerCardAndSheetView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var optionsSheetsStateManager: OptionsSheetsStateManager
    let pageGeometry: GeometryProxy
    
    var body: some View {
        Button {
            self.optionsSheetsStateManager.playerSheetBinding = true
        } label: {
            PlayerCardView(playerViewModel: self.playerViewModel)
        }
        .withInspectSheet(isPresented: self.$optionsSheetsStateManager.playerSheetBinding, pageGeometry: self.pageGeometry, content: AnyView(
            Group {
                YonderText(text: "Your \(Term.stats.capitalized)", size: .inspectSheetTitle)
                    
                VStack(alignment: .leading, spacing: 6) {
                    StatView(title: Term.armorPoints.capitalized, value: self.playerViewModel.armorPoints, maxValue: self.playerViewModel.maxArmorPoints, image: YonderImages.shieldIcon)
                    
                    StatView(title: Term.health.capitalized, value: self.playerViewModel.health, maxValue: self.playerViewModel.maxHealth, image: YonderImages.healthIcon)
                    
                    StatView(title: Term.gold.capitalized, prefix: Term.currencySymbol, value: self.playerViewModel.gold, image: YonderImages.goldIcon)
                }
                
                SectionSpacingView()
                
                YonderText(text: Term.buffsAndEffects.capitalized, size: .inspectSheetTitle)
            }
        ))
    }
}
