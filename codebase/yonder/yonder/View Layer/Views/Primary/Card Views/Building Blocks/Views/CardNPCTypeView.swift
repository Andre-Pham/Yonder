//
//  CardNPCTypeView.swift
//  yonder
//
//  Created by Andre Pham on 15/4/2022.
//

import SwiftUI

struct CardNPCTypeView: View {
    @StateObject private var playerViewModel = GameManager.instance.playerVM
    private var location: LocationViewModel {
        return self.playerViewModel.locationViewModel
    }
    
    var body: some View {
        YonderIconTextPair(
            image: self.location.getTypeImage(),
            text: self.location.getTypeName(),
            size: .cardSubscript,
            iconSize: .cardSubscript
        )
    }
}

struct CardNPCTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            CardNPCTypeView()
        }
    }
}
