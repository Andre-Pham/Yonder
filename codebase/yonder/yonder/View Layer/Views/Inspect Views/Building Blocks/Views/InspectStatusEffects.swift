//
//  InspectStatusEffects.swift
//  yonder
//
//  Created by Andre Pham on 5/7/2022.
//

import SwiftUI

struct InspectStatusEffects: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        ForEach(self.playerViewModel.statusEffectViewModels, id: \.id) { statusEffectViewModel in
            if let effectsDescription = statusEffectViewModel.effectsDescription {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        YonderText(text: statusEffectViewModel.name, size: .inspectSheetBody)
                        
                        YonderText(text: "|", size: .inspectSheetBody)
                        
                        YonderTextNumeralHStack {
                            YonderIconNumeralPair(image: YonderImages.timeRemainingIcon, numeral: statusEffectViewModel.timeRemaining, size: .inspectSheetBody, iconSize: .inspectSheet)
                            
                            YonderText(text: "/\(statusEffectViewModel.initialTimeRemaining)", size: .inspectSheetBody)
                        }
                    }
                    
                    if let indicative = statusEffectViewModel.getIndicativeValue(playerViewModel: self.playerViewModel) {
                        IndicativeEffectsDescriptionView(
                            effectsDescription: effectsDescription,
                            indicative: indicative,
                            size: .inspectSheetBody)
                    } else {
                        YonderText(text: effectsDescription, size: .inspectSheetBody)
                    }
                }
            }
        }
    }
}

struct InspectStatusEffects_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                InspectStatusEffects(playerViewModel: PreviewObjects.playerViewModel)
            }
        }
    }
}
