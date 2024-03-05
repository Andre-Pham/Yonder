//
//  InspectBuffs.swift
//  yonder
//
//  Created by Andre Pham on 25/6/2022.
//

import Foundation
import SwiftUI

struct InspectBuffs: View {
    @ObservedObject var actorViewModel: ActorViewModel
    
    var body: some View {
        ForEach(self.actorViewModel.allBuffs, id: \.id) { buffViewModel in
            if let effectsDescription = buffViewModel.effectsDescription {
                YonderBorder4 {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            YonderText(text: buffViewModel.sourceName, size: .inspectSheetBody)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(YonderBorder4Presets.outlineColor)
                            
                            if let timeRemaining = buffViewModel.timeRemaining,
                               let initialTimeRemaining = buffViewModel.initialTimeRemaining {
                                
                                YonderBorder4Presets.outlineColor
                                    .frame(
                                        width: YonderBorder4Presets.outlineThickness,
                                        height: YonderBorder4Presets.outlineThickness
                                    )
                                
                                YonderTextNumeralHStack {
                                    YonderIconNumeralPair(image: YonderIcons.timeRemainingIcon, numeral: timeRemaining, size: .inspectSheetBody, iconSize: .inspectSheet)
                                    
                                    YonderText(text: "/\(initialTimeRemaining)", size: .inspectSheetBody)
                                }
                            }
                        }
                        
                        YonderBorder4Presets.outlineColor
                            .frame(height: YonderBorder4Presets.outlineThickness)
                            .padding(.vertical, 6.0)
                            .padding(.horizontal, -YonderCoreGraphics.innerPadding)
                        
                        YonderText(text: effectsDescription, size: .inspectSheetBody)
                    }
                    .padding(YonderCoreGraphics.innerPadding)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct InspectOngoingEffects_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            InspectBody {
                InspectBuffs(actorViewModel: PreviewObjects.playerViewModel)
            }
        }
    }
}
