//
//  AcceptOfferButton.swift
//  yonder
//
//  Created by Andre Pham on 27/2/2024.
//

import SwiftUI

struct AcceptOfferButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var friendlyViewModel: FriendlyViewModel
    @ObservedObject var offerViewModel: OfferViewModel
    private var isDisabled: Bool {
        return !self.offerViewModel.canBeAccepted(playerViewModel: self.playerViewModel)
    }
    
    var body: some View {
        YonderBorder4 {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    YonderText(text: self.offerViewModel.name, size: .buttonBody)
                        .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                    
                    YonderText(text: self.offerViewModel.description, size: .buttonBodySubscript)
                    
                    YonderWideButton(text: Strings("button.acceptOffer").local) {
                        self.friendlyViewModel.acceptOffer(
                            self.offerViewModel,
                            player: self.playerViewModel
                        )
                    }
                    .disabledWhen(self.isDisabled)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(YonderCoreGraphics.innerPadding)
        }
    }
}

#Preview {
    PreviewContentView {
        AcceptOfferButton(
            playerViewModel: PreviewObjects.playerViewModel,
            friendlyViewModel: PreviewObjects.friendlyViewModel,
            offerViewModel: PreviewObjects.friendlyViewModel.offers.first!
        )
    }
}

