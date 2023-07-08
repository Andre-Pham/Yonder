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
            CardNPCTypeView()
            
            CardRowView(value: friendlyViewModel.offersRemaining, image: YonderIcons.offerIcon)
        }
    }
}

struct FriendlyCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            FriendlyCardView(friendlyViewModel: PreviewObjects.friendlyViewModel)
        }
    }
}
