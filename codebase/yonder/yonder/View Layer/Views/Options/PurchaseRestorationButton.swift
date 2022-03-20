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
    private let baseRestorationAmount = 10
    
    var body: some View {
        ZStack(alignment: .bottom) {
            YonderWideButtonBody {
                self.useButtonActive.toggle()
            } label: {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                YonderText(text: "\(Term.restore.capitalized):", size: .buttonBody)
                                
                                YonderIconTextPair(image: self.restorationOptionViewModel.getImage(), text: "\(self.baseRestorationAmount)", size: .buttonBody)
                                
                                Spacer()
                                
                                YonderIconNumeralPair(prefix: Term.currencySymbol, image: YonderImages.goldIcon, numeral: self.restorationOptionViewModel.getPricePerUnit()*self.baseRestorationAmount, size: .buttonBody, animationIsActive: false)
                                    .padding(.horizontal, YonderCoreGraphics.padding*1.5)
                                    .padding(.vertical, YonderCoreGraphics.padding)
                                    .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                            }
                        }
                    }
                    .padding(.horizontal, YonderCoreGraphics.padding)
                    
                    if self.useButtonActive {
                        // Expand button frame
                        YonderWideButton(text: "") {}
                        .padding(.top, YonderCoreGraphics.padding)
                        .hidden()
                    }
                }
            }
            
            if self.useButtonActive {
                YonderWideButton(text: Term.purchase.capitalized) {
                    self.restorationOptionViewModel.restore(amount: self.baseRestorationAmount, to: self.playerViewModel)
                }
                .padding(.horizontal, YonderCoreGraphics.padding)
                .padding(.bottom, YonderCoreGraphics.padding)
                .disabled(self.restorationOptionViewModel.restoreIsDisabled(playerViewModel: self.playerViewModel, amount: self.baseRestorationAmount))
                .opacity(self.restorationOptionViewModel.restoreIsDisabled(playerViewModel: self.playerViewModel, amount: self.baseRestorationAmount) ? YonderCoreGraphics.disabledButtonOpacity : 1)
            }
        }
    }
}

struct PurchaseRestorationButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
            
            PurchaseRestorationButton(playerViewModel: PlayerViewModel(Player(maxHealth: 200, location: NoLocation())), restorationOptionViewModel: RestoreOptionViewModel(restoreOption: .health, restorerViewModel: RestorerViewModel(Restorer(options: [.health]))))
        }
    }
}
