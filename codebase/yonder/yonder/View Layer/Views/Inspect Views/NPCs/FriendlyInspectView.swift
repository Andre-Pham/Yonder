//
//  FriendlyInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct FriendlyInspectView: View {
    @ObservedObject var friendlyViewModel: FriendlyViewModel
    var offerDescription: String {
        if self.friendlyViewModel.offersRemaining == 1 {
            return Strings("stat.description.offersRemainingSingular").local
        }
        return Strings("stat.description.offersRemaining1Param").localWithArgs(self.friendlyViewModel.offersRemaining)
    }
    
    var body: some View {
        InspectNPCBody(
            name: self.friendlyViewModel.name,
            description: self.friendlyViewModel.description,
            locationType: LocationType.friendly
        ) {
            YonderText(text: Strings("inspect.title.stats").local, size: .inspectSheetTitle)
            
            InspectStatsBody {
                InspectStatView(title: Strings("stat.offersRemaining").local, value: self.friendlyViewModel.offersRemaining, image: YonderIcons.offerIcon)
                
                YonderText(text: "(\(self.offerDescription))", size: .inspectSheetBody)
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
