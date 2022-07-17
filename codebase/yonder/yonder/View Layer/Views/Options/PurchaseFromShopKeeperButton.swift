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
    @State private var useButtonActive = false
    @State private var infoSheetActive = false
    @State private var accessorySelectionSheetActive = false
    private let amount = 1
    
    // TODO: - This entire button really needs a rework, but i'm not really sure how to implement layered buttons without using this approach
    var body: some View {
        ZStack(alignment: .bottom) {
            YonderWideButtonBody {
                self.useButtonActive.toggle()
            } label: {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            YonderText(text: self.purchasableViewModel.name, size: .buttonBody)
                            
                            YonderTextNumeralHStack {
                                YonderText(text: Strings.Stat.RemainingStock.local.rightPadded(by: ": "), size: .buttonBodySubscript)
                                
                                YonderNumeral(number: self.purchasableViewModel.stockRemaining, size: .buttonBodySubscript)
                            }
                            
                            HStack {
                                YonderWideButton(text: Strings.Button.Info.local, verticalPadding: YonderCoreGraphics.padding, action: {})
                                    .hidden()
                                
                                PriceTagView(price: self.purchasableViewModel.price, indicativePrice: self.playerViewModel.getIndicativePrice(from: self.purchasableViewModel.price))
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
            
            VStack {
                HStack {
                    YonderWideButton(text: Strings.Button.Info.local, verticalPadding: YonderCoreGraphics.padding) {
                        self.infoSheetActive.toggle()
                    }
                    .withInspectSheet(
                        isPresented: self.$infoSheetActive,
                        pageGeometry: pageGeometry,
                        content: AnyView(
                            PurchasableInspectView(purchasableViewModel: self.purchasableViewModel, playerViewModel: self.playerViewModel)
                    ))
                    
                    PriceTagView(price: self.purchasableViewModel.price, indicativePrice: self.playerViewModel.getIndicativePrice(from: self.purchasableViewModel.price))
                        .hidden()
                }
                .padding(.horizontal, YonderCoreGraphics.padding)
                .padding(.bottom, YonderCoreGraphics.padding + YonderCoreGraphics.borderWidth/2)
                
                if self.useButtonActive {
                    // Expand button frame
                    YonderWideButton(text: "") {}
                    .padding(.top, YonderCoreGraphics.padding)
                    .hidden()
                }
            }
            
            if self.useButtonActive {
                YonderWideButton(text: Strings.Button.Purchase.local) {
                    if let accessory = self.purchasableViewModel.getAccessoryViewModel(), accessory.isPeripheral {
                        self.accessorySelectionSheetActive = true
                    } else {
                        self.purchasableViewModel.purchase(by: self.playerViewModel, amount: self.amount)
                    }
                }
                .padding(.horizontal, YonderCoreGraphics.padding)
                .padding(.bottom, YonderCoreGraphics.padding)
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
                    playerViewModel: PreviewObjects.playerViewModel(),
                    purchasableViewModel: PreviewObjects.purchasableViewModel,
                    pageGeometry: geo)
            }
        }
    }
}
