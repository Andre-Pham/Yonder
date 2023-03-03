//
//  EquipArmorView.swift
//  yonder
//
//  Created by Andre Pham on 3/3/2023.
//

import SwiftUI

struct EquipArmorView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var armorViewModel: ArmorViewModel
    @Environment(\.dismiss) private var dismiss
    let onConfirm: (_ equipArmor: Bool) -> Void
    
    var body: some View {
        InspectBody {
            YonderText(text: Strings("inspect.armorEquip.title").local, size: .inspectSheetTitle)
            
            InspectSectionSpacingView()
            
            YonderText(text: Strings("inspect.armorEquip.currentlyEquipped").local, size: .inspectSheetBody)
            
            ArmorInspectView(armorViewModel: self.playerViewModel.getArmorViewModel(matching: self.armorViewModel.type))
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 24)
                .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
    
            InspectSectionSpacingView()
            
            YonderText(text: Strings("inspect.armorEquip.replacingWith").local, size: .inspectSheetBody)
            
            ArmorInspectView(armorViewModel: self.armorViewModel)
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 24)
                .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
            
            InspectSectionSpacingView()
            
            YonderWideButton(text: Strings("button.equip").local) {
                self.onConfirm(true)
            }
            
            YonderWideButton(text: Strings("button.cancel").local) {
                self.onConfirm(false)
            }
        }
    }
}

struct EquipArmorView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            EquipArmorView(
                playerViewModel: PreviewObjects.playerViewModel,
                armorViewModel: PreviewObjects.armorViewModel
            ) { equipArmor in
                print("Player wants to equip: \(equipArmor)")
            }
        }
    }
}
