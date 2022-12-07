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
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        YonderText(text: timedEventViewModel.name, size: .inspectSheetBody)
                        
                        YonderText(text: "|", size: .inspectSheetBody)
                        
                        YonderTextNumeralHStack {
                            YonderIconNumeralPair(image: YonderIcons.timeRemainingIcon, numeral: timedEventViewModel.timeRemaining, size: .inspectSheetBody, iconSize: .inspectSheet)
                            
                            YonderText(text: "/\(timedEventViewModel.initialTimeRemaining)", size: .inspectSheetBody)
                        }
                    }
                    
                    if let indicative = timedEventViewModel.getIndicativeValue(actorViewModel: self.actorViewModel) {
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
