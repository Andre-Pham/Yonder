//
//  PurchaseRestorationButton.swift
//  yonder
//
//  Created by Andre Pham on 16/3/2022.
//

import SwiftUI

struct PurchaseRestorationButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var restorationOptionViewModel: RestoreOptionViewModel
    @State private var useButtonActive = false
    private let baseRestorationAmount = Restorer.bundleSize
    
    var body: some View {
        YonderExpandableWideButtonBody(isExpanded: self.$useButtonActive) {
            VStack {
                HStack {
                    YonderText(text: "\(Term.restore.capitalized):", size: .buttonBody)
                    
                    YonderIconTextPair(image: self.restorationOptionViewModel.getImage(), text: "\(self.baseRestorationAmount)", size: .buttonBody)
                    
                    Spacer()
                    
                    PriceTagView(price: self.restorationOptionViewModel.getBundlePrice())
                }
            }
        } expandedContent: {
            YonderWideButton(text: Term.purchase.capitalized) {
                self.restorationOptionViewModel.restore(amount: self.baseRestorationAmount, to: self.playerViewModel)
            }
            .disabledWhen(self.restorationOptionViewModel.restoreIsDisabled(playerViewModel: self.playerViewModel, amount: self.baseRestorationAmount))
        }
    }
}

struct PurchaseRestorationButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            PurchaseRestorationButton(playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: NoLocation())), restorationOptionViewModel: RestoreOptionViewModel(restoreOption: .health, restorerViewModel: RestorerViewModel(Restorer(options: [.health]))))
        }
    }
}
