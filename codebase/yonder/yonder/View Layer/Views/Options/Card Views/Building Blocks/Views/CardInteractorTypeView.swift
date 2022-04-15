//
//  CardInteractorTypeView.swift
//  yonder
//
//  Created by Andre Pham on 15/4/2022.
//

import SwiftUI

struct CardInteractorTypeView: View {
    private var location: LocationViewModel {
        return gameManager.playerLocationVM.locationViewModel
    }
    
    var body: some View {
        YonderIconTextPair(image: self.location.getTypeImage(), text: self.location.getTypeName(), size: .cardSubscript, iconSize: .cardSubscript)
    }
}

struct CardInteractorSubheading_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            CardInteractorTypeView()
        }
    }
}
