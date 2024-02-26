//
//  PurchaseFromShopkeeperButton.swift
//  yonder
//
//  Created by Andre Pham on 20/3/2022.
//

import SwiftUI

struct PurchaseFromShopKeeperButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var purchasableViewModel: PurchasableViewModel
    var pageGeometry: GeometryProxy
    @State private var infoSheetActive = false
    @State private var accessorySelectionSheetActive = false
    private let amount = 1
    
    var body: some View {
        YonderBorder4 {
            VStack {
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        YonderText(
                            text: self.purchasableViewModel.name,
                            size: .buttonBody
                        )
                        
                        YonderTextNumeralHStack {
                            YonderText(
                                text: Strings("stat.remainingStock").local.rightPadded(by: ": "),
                                size: .buttonBodySubscript
                            )

                            YonderNumeral(
                                number: self.purchasableViewModel.stockRemaining,
                                size: .buttonBodySubscript
                            )
                        }
                    }
                    .padding(.horizontal, YonderCoreGraphics.padding)
                    .padding(.vertical, YonderCoreGraphics.textVerticalPadding)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    YonderWideButton(text: Strings("button.info").local, verticalPadding: YonderCoreGraphics.padding) {
                        self.infoSheetActive.toggle()
                    }
                    .withInspectSheet(
                        isPresented: self.$infoSheetActive,
                        pageGeometry: pageGeometry,
                        content: AnyView(
                            PurchasableInspectView(purchasableViewModel: self.purchasableViewModel, playerViewModel: self.playerViewModel)
                    ))
                    
                    PriceTagButton(
                        price: self.purchasableViewModel.price,
                        indicativePrice: self.playerViewModel.getIndicativePrice(
                            from: self.purchasableViewModel.price
                        )
                    ) {
                        if let accessory = self.purchasableViewModel.getAccessoryViewModel(),
                           !accessory.isPeripheral {
                            self.accessorySelectionSheetActive = true
                        } else {
                            self.purchasableViewModel.purchase(
                                by: self.playerViewModel,
                                amount: self.amount
                            )
                        }
                    }
                    .disabledWhen(self.purchasableViewModel.purchaseIsDisabled(for: self.playerViewModel, amount: self.amount))
                    .withInspectSheet(
                        isPresented: self.$accessorySelectionSheetActive,
                        pageGeometry: self.pageGeometry,
                        content: AnyView(
                            AccessorySlotSelectionInspectView(playerViewModel: self.playerViewModel) { selection in
                                guard let _ = self.purchasableViewModel.getAccessoryViewModel() else {
                                    return
                                }
                                if let id = selection {
                                    // If nil, we're inserting to an empty accessory slot
                                    self.playerViewModel.unequipAccessory(id: id, cacheLocation: true)
                                }
                                self.purchasableViewModel.purchase(by: self.playerViewModel, amount: self.amount)
                            }
                    ))
                }
                .padding(.horizontal, YonderCoreGraphics.padding)
                .padding(.bottom, YonderCoreGraphics.padding)
            }
        }
    }
}

struct PurchaseFromShopKeeperButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                PurchaseFromShopKeeperButton(
                    playerViewModel: PreviewObjects.playerViewModel,
                    purchasableViewModel: PreviewObjects.purchasableViewModel,
                    pageGeometry: geo)
            }
        }
    }
}
