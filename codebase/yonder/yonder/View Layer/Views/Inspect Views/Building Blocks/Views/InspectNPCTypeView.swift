//
//  InspectNPCTypeView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct InspectNPCTypeView: View {
    private var location: LocationViewModel {
        return gameManager.playerLocationVM.locationViewModel
    }
    
    var body: some View {
        YonderIconTextPair(image: self.location.getTypeImage(), text: self.location.getTypeName(), size: .inspectSheetBody, iconSize: .inspectSheet)
    }
}

struct InspectNPCTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            InspectNPCTypeView()
        }
    }
}
