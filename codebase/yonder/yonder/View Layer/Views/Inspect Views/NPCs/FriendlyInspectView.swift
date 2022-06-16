//
//  FriendlyInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct FriendlyInspectView: View {
    @ObservedObject var friendlyViewModel: FriendlyViewModel
    var offerSuffix: String {
        return self.friendlyViewModel.offersRemaining == 1 ? "" : "s"
    }
    
    var body: some View {
        InspectNPCBody(
            name: self.friendlyViewModel.name,
            description: self.friendlyViewModel.description,
            locationType: LocationType.friendly
        ) {
            YonderText(text: Term.stats.capitalized, size: .inspectSheetTitle)
            
            InspectStatsBody {
                InspectStatView(title: "Offers remaining", value: self.friendlyViewModel.offersRemaining, image: YonderImages.offerIcon)
                
                YonderText(text: "(You may accept \(self.friendlyViewModel.offersRemaining) more offer\(self.offerSuffix))", size: .inspectSheetBody)
            }
        }
    }
}

struct FriendlyInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            FriendlyInspectView(friendlyViewModel: PreviewObjects.friendlyViewModel)
        }
    }
}
