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
            VStack(alignment: .center) {
                YonderText(text: self.locationViewModel.name, size: .inspectSheetTitle)
                
                YonderText(text: self.locationViewModel.description, size: .inspectSheetBody)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 6)
            
            self.locationViewModel.tileBackgroundImage.image
                .interpolation(.none)
                .resizable()
                .scaledToFit()
            
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
