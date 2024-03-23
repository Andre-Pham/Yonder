//
//  InspectTimedEvents.swift
//  yonder
//
//  Created by Andre Pham on 7/7/2022.
//

import SwiftUI

struct InspectTimedEvents: View {
    @ObservedObject var actorViewModel: ActorViewModel
    
    var body: some View {
        ForEach(self.actorViewModel.timedEventsViewModels, id: \.id) { timedEventViewModel in
            if let effectsDescription = timedEventViewModel.effectsDescription {
                YonderBorder4 {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            YonderText(text: timedEventViewModel.name, size: .inspectSheetBody)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(YonderBorder4Presets.outlineColor)
                            
                            YonderBorder4Presets.outlineColor
                                .frame(
                                    width: YonderBorder4Presets.outlineThickness,
                                    height: YonderBorder4Presets.outlineThickness
                                )
                            
                            YonderTextNumeralHStack {
                                YonderIconNumeralPair(image: YonderIcons.timeRemainingIcon, numeral: timedEventViewModel.timeRemaining, size: .inspectSheetBody, iconSize: .inspectSheet)
                                
                                YonderText(text: "/\(timedEventViewModel.initialTimeRemaining)", size: .inspectSheetBody)
                            }
                        }
                        
                        YonderBorder4Presets.outlineColor
                            .frame(height: YonderBorder4Presets.outlineThickness)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal, -YonderCoreGraphics.innerPadding)
                        
                        if let indicative = timedEventViewModel.getIndicativeValue(actorViewModel: self.actorViewModel) {
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

struct InspectTimedEvents_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                InspectTimedEvents(actorViewModel: PreviewObjects.playerViewModel)
            }
        }
    }
}
