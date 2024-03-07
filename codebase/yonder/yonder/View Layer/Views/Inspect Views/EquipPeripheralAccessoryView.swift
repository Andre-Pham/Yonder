//
//  EquipPeripheralAccessoryView.swift
//  yonder
//
//  Created by Andre Pham on 3/3/2023.
//

import SwiftUI

struct EquipPeripheralAccessoryView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var accessoryViewModel: AccessoryViewModel
    @Environment(\.dismiss) private var dismiss
    let onConfirm: (_ equip: Bool) -> Void
    
    var body: some View {
        InspectBody {
            YonderText(
                text: Strings("inspect.equip.peripheralAccessory.title").local,
                size: .inspectSheetTitle,
                multilineTextAlignment: .center
            )
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
                AccessoryInspectView(
                    accessoryViewModel: self.playerViewModel.peripheralAccessoryViewModel
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
                AccessoryInspectView(
                    accessoryViewModel: self.accessoryViewModel
                )
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

struct EquipPeripheralAccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            EquipPeripheralAccessoryView(
                playerViewModel: PreviewObjects.playerViewModel,
                accessoryViewModel: PreviewObjects.peripheralAccessoryViewModel
            ) { equipAccessory in
                print("Player wants to equip: \(equipAccessory)")
            }
        }
    }
}
