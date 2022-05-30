//
//  InspectLocationView.swift
//  yonder
//
//  Created by Andre Pham on 14/5/2022.
//

import SwiftUI

struct InspectLocationView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            YonderText(text: self.locationViewModel.name, size: .inspectSheetTitle)
            
            YonderText(text: self.locationViewModel.description, size: .inspectSheetBody)
            
            self.locationViewModel.image
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .clipped()
                .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
            
            YonderWideButtonBody {
                GameManager.instance.playerVM.travel(to: self.locationViewModel)
                dismiss()
            } label: {
                YonderIconTextPair(image: self.locationViewModel.getTypeImage(), text: "Warp", size: .buttonBody)
            }
        }
    }
}
