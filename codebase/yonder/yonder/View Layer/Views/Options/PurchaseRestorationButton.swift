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
                    
                    YonderIconNumeralPair(prefix: Term.currencySymbol, image: YonderImages.goldIcon, numeral: self.restorationOptionViewModel.getBundlePrice(), size: .buttonBody)
                        .padding(.horizontal, YonderCoreGraphics.padding*1.5)
                        .padding(.vertical, YonderCoreGraphics.padding)
                        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                }
            }
        } expandedContent: {
            YonderWideButton(text: Term.purchase.capitalized) {
                self.restorationOptionViewModel.restore(amount: self.baseRestorationAmount, to: self.playerViewModel)
            }
            .disabled(self.restorationOptionViewModel.restoreIsDisabled(playerViewModel: self.playerViewModel, amount: self.baseRestorationAmount))
            .opacity(self.restorationOptionViewModel.restoreIsDisabled(playerViewModel: self.playerViewModel, amount: self.baseRestorationAmount) ? YonderCoreGraphics.disabledButtonOpacity : 1)
        }
    }
}

struct PurchaseRestorationButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            PurchaseRestorationButton(playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: NoLocation())), restorationOptionViewModel: RestoreOptionViewModel(restoreOption: .health, restorerViewModel: RestorerViewModel(Restorer(options: [.health]))))
        }
    }
}
