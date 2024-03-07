//
//  AccessorySlotSelectionInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/7/2022.
//

import SwiftUI

struct AccessorySlotSelectionInspectView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @Environment(\.dismiss) private var dismiss
    let onSelection: (_ selection: UUID?) -> Void
    
    var body: some View {
        InspectBody {
            YonderText(
                text: Strings("inspect.accessorySlotSelection.title").local,
                size: .inspectSheetTitle,
                multilineTextAlignment: .center
            )
            .frame(maxWidth: .infinity)
            
            YonderText(
                text: Strings("inspect.accessorySlotSelection.description").local,
                size: .inspectSheetBody,
                multilineTextAlignment: .center
            )
            .frame(maxWidth: .infinity)
            
            InspectSectionSpacingView()
            
            VStack {
                SurroundingBrackets(bracket: "[", size: .title5) {
                    YonderText(text: Strings("inspect.accessorySlotSelection.header").local, size: .title5)
                }
                .frame(maxWidth: .infinity)
                
                if !self.playerViewModel.accessorySlotsFull {
                    YonderWideButtonBody {
                        onSelection(nil)
                        dismiss()
                    } label: {
                        SurroundingBrackets(bracket: "[", size: .buttonBody) {
                            YonderText(
                                text: Strings("button.insertToEmptySlot").local.uppercased(),
                                size: .buttonBody
                            )
                        }
                    }
                }
                
                ForEach(self.playerViewModel.accessoryViewModels, id: \.id) { accessoryViewModel in
                    YonderBorder4 {
                        VStack {
                            AccessoryInspectView(
                                accessoryViewModel: accessoryViewModel
                            )
                            .padding(.bottom, YonderCoreGraphics.innerPadding)
                            
                            YonderWideButton(
                                text: Strings("button.replace").local.uppercased()
                            ) {
                                onSelection(accessoryViewModel.id)
                                dismiss()
                            }
                        }
                        .padding(YonderCoreGraphics.innerPadding)
                    }
                }
            }
        }
    }
}

struct AccessorySlotSelectionInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            AccessorySlotSelectionInspectView(playerViewModel: PreviewObjects.playerViewModel) { selection in
                print(selection?.uuidString ?? "nil")
            }
        }
    }
}
