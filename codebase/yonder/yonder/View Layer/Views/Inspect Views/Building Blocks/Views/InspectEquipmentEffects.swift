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
            YonderBorder4 {
                VStack(alignment: .leading, spacing: 0) {
                    YonderText(text: equipmentEffectViewModel.sourceName, size: .inspectSheetBody)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(YonderBorder4Presets.outlineColor)
                    
                    YonderBorder4Presets.outlineColor
                        .frame(height: YonderBorder4Presets.outlineThickness)
                        .padding(.vertical, 6.0)
                        .padding(.horizontal, -YonderCoreGraphics.innerPadding)
                    
                    YonderText(text: equipmentEffectViewModel.effectsDescription, size: .inspectSheetBody)
                }
                .padding(YonderCoreGraphics.innerPadding)
                .frame(maxWidth: .infinity)
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
