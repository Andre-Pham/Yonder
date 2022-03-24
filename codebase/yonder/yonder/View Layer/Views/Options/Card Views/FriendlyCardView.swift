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
            CardRowView(value: friendlyViewModel.offersRemaining, image: YonderImages.missingIcon)
        }
    }
}

