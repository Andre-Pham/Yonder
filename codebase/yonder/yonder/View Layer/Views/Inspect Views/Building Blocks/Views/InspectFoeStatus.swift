//
//  InspectFoeStatus.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import SwiftUI

struct InspectFoeStatus: View {
    @ObservedObject var foeViewModel: FoeViewModel
    
    var body: some View {
        // Ongoing Effects
        if !self.foeViewModel.allBuffs.isEmpty {
            Group {
                InspectSectionSpacingView()
                
                YonderText(text: Strings("inspect.title.buffs").local, size: .inspectSheetTitle)
                
                InspectBuffs(actorViewModel: self.foeViewModel)
            }
        }
        
        // Status Effects
        if !self.foeViewModel.statusEffectViewModels.isEmpty {
            Group {
                InspectSectionSpacingView()
                
                YonderText(text: Strings("inspect.title.statusEffects").local, size: .inspectSheetTitle)
                
                InspectStatusEffects(actorViewModel: self.foeViewModel)
            }
        }
        
        // Timed Events
        if !self.foeViewModel.timedEventsViewModels.isEmpty {
            Group {
                InspectSectionSpacingView()
                
                YonderText(text: Strings("inspect.title.timedEvents").local, size: .inspectSheetTitle)
                
                InspectTimedEvents(actorViewModel: self.foeViewModel)
            }
        }
    }
}

struct InspectFoeStatus_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            InspectBody {
                InspectFoeStatus(foeViewModel: PreviewObjects.foeViewModel)
            }
        }
    }
}
