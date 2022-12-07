//
//  InspectPlayerStatus.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import SwiftUI

struct InspectPlayerStatus: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        // Ongoing Effects
        if !(self.playerViewModel.allBuffs.isEmpty && self.playerViewModel.allEquipmentEffects.isEmpty) {
            Group {
                InspectSectionSpacingView()
                
                YonderText(text: Strings("inspect.title.buffs").local, size: .inspectSheetTitle)
                
                InspectEquipmentEffects(playerViewModel: self.playerViewModel)
                
                InspectBuffs(actorViewModel: self.playerViewModel)
            }
        }
        
        // Status Effects
        if !self.playerViewModel.statusEffectViewModels.isEmpty {
            Group {
                InspectSectionSpacingView()
                
                YonderText(text: Strings("inspect.title.statusEffects").local, size: .inspectSheetTitle)
                
                InspectStatusEffects(actorViewModel: self.playerViewModel)
            }
        }
        
        if !self.playerViewModel.timedEventsViewModels.isEmpty {
            // Timed Events
            Group {
                InspectSectionSpacingView()
                
                YonderText(text: Strings("inspect.title.timedEvents").local, size: .inspectSheetTitle)
                
                InspectTimedEvents(actorViewModel: self.playerViewModel)
            }
        }
    }
}

struct InspectPlayerStatus_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            InspectBody {
                InspectPlayerStatus(playerViewModel: PreviewObjects.playerViewModel)
            }
        }
    }
}
