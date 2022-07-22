//
//  InspectEquipmentEffects.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import SwiftUI

struct InspectEquipmentEffects: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        ForEach(self.playerViewModel.allEquipmentEffects, id: \.id) { equipmentEffectViewModel in
            VStack(alignment: .leading, spacing: 0) {
                YonderText(text: equipmentEffectViewModel.sourceName, size: .inspectSheetBody)
                
                YonderText(text: equipmentEffectViewModel.effectsDescription, size: .inspectSheetBody)
            }
        }
    }
}

struct InspectEquipmentEffects_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            InspectBody {
                InspectEquipmentEffects(playerViewModel: PreviewObjects.playerViewModel)
            }
        }
    }
}
