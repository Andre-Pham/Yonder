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
    let onConfirm: (_ equip: Bool) -> Void
    
    var body: some View {
        InspectBody {
            YonderText(text: Strings("inspect.equip.armor.title").local, size: .inspectSheetTitle)
                .frame(maxWidth: .infinity)
            
            InspectSectionSpacingView()
            
            SurroundingBrackets(bracket: "[", size: .inspectSheetBody) {
                YonderText(
                    text: Strings("inspect.equip.currentlyEquipped").local,
                    size: .inspectSheetBody
                )
            }
            .frame(maxWidth: .infinity)
            
            YonderBorder4 {
                ArmorInspectView(
                    armorViewModel: self.playerViewModel.getArmorViewModel(
                        matching: self.armorViewModel.type
                    )
                )
                .padding(YonderCoreGraphics.innerPadding)
            }
    
            InspectSectionSpacingView()
            
            SurroundingBrackets(bracket: "[", size: .inspectSheetBody) {
                YonderText(
                    text: Strings("inspect.equip.replacingWith").local,
                    size: .inspectSheetBody
                )
            }
            .frame(maxWidth: .infinity)
            
            YonderBorder4 {
                ArmorInspectView(armorViewModel: self.armorViewModel)
                    .padding(YonderCoreGraphics.innerPadding)
            }
            
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
