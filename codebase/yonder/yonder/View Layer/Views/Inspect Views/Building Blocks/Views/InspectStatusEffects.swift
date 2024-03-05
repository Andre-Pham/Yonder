//
//  InspectStatusEffects.swift
//  yonder
//
//  Created by Andre Pham on 5/7/2022.
//

import SwiftUI

struct InspectStatusEffects: View {
    @ObservedObject var actorViewModel: ActorViewModel
    
    var body: some View {
        ForEach(self.actorViewModel.statusEffectViewModels, id: \.id) { statusEffectViewModel in
            if let effectsDescription = statusEffectViewModel.effectsDescription {
                YonderBorder4 {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            YonderText(text: statusEffectViewModel.name, size: .inspectSheetBody)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(YonderBorder4Presets.outlineColor)
                            
                            YonderBorder4Presets.outlineColor
                                .frame(
                                    width: YonderBorder4Presets.outlineThickness,
                                    height: YonderBorder4Presets.outlineThickness
                                )
                            
                            YonderTextNumeralHStack {
                                YonderIconNumeralPair(image: YonderIcons.timeRemainingIcon, numeral: statusEffectViewModel.timeRemaining, size: .inspectSheetBody, iconSize: .inspectSheet)
                                
                                YonderText(text: "/\(statusEffectViewModel.initialTimeRemaining)", size: .inspectSheetBody)
                            }
                        }
                        
                        YonderBorder4Presets.outlineColor
                            .frame(height: YonderBorder4Presets.outlineThickness)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal, -YonderCoreGraphics.innerPadding)
                        
                        if let indicative = statusEffectViewModel.getIndicativeValue(actorViewModel: self.actorViewModel) {
                            IndicativeEffectsDescriptionView(
                                effectsDescription: effectsDescription,
                                indicative: indicative,
                                size: .inspectSheetBody)
                        } else {
                            YonderText(text: effectsDescription, size: .inspectSheetBody)
                        }
                    }
                    .padding(YonderCoreGraphics.innerPadding)
                    .frame(maxWidth: .infinity)
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
                InspectStatusEffects(actorViewModel: PreviewObjects.playerViewModel)
            }
        }
    }
}
