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
                .frame(maxWidth: .infinity)
            
            self.locationViewModel.tileBackgroundImage.image
                .interpolation(.none)
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .clipped()
            
            YonderWideButtonBody {
                GameManager.instance.playerVM.travel(to: self.locationViewModel)
                dismiss()
            } label: {
                YonderIconTextPair(image: self.locationViewModel.getTypeImage(), text: Strings("button.warp").local, size: .buttonBody)
            }
        }
    }
}

struct InspectLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            InspectBody {
                InspectLocationView(locationViewModel: PreviewObjects.locationViewModel)
            }
        }
    }
}
