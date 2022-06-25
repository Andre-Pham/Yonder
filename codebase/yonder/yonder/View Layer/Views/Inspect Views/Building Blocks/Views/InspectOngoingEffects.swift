//
//  InspectOngoingEffects.swift
//  yonder
//
//  Created by Andre Pham on 25/6/2022.
//

import Foundation
import SwiftUI

struct InspectOngoingEffects: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        ForEach(self.playerViewModel.allBuffs, id: \.id) { buffViewModel in
            if let effectsDescription = buffViewModel.effectsDescription {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        YonderText(text: buffViewModel.sourceName, size: .inspectSheetBody)
                        
                        if let timeRemaining = buffViewModel.timeRemaining, let initialTimeRemaining = buffViewModel.initialTimeRemaining {
                            YonderText(text: "|", size: .inspectSheetBody)
                            
                            YonderTextNumeralHStack {
                                YonderIconNumeralPair(image: YonderImages.timeRemaining, numeral: timeRemaining, size: .inspectSheetBody, iconSize: .inspectSheet)
                                
                                YonderText(text: "/\(initialTimeRemaining)", size: .inspectSheetBody)
                            }
                        }
                    }
                    
                    YonderText(text: effectsDescription, size: .inspectSheetBody)
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
            
            InspectOngoingEffects(playerViewModel: PreviewObjects.playerViewModel())
        }
    }
}
