//
//  FriendlyCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct FriendlyCardView: View {
    @ObservedObject var friendlyViewModel: FriendlyViewModel
    
    var body: some View {
        CardBody(name: self.friendlyViewModel.name) {
            CardInteractorTypeView()
            
            CardRowView(value: friendlyViewModel.offersRemaining, image: YonderImages.missingIcon)
        }
    }
}

struct FriendlyCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            FriendlyCardView(friendlyViewModel: FriendlyViewModel(Friendly(
                name: "Winston",
                description: "With a Y",
                offers: [FreeGoldOffer(goldAmount: 200)], offerLimit: 1)))
        }
    }
}
