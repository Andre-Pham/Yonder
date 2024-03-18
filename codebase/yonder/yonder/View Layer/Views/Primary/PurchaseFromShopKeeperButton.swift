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
    @State private var peripheralAccessoryEquipSheetActive = false
    @State private var armorEquipSheetActive = false
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
                        .padding(.bottom, YonderCoreGraphics.buttonTitleSpacing)
                        
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
                    .padding(.horizontal, YonderCoreGraphics.innerPadding)
                    .padding(.top, YonderCoreGraphics.innerPadding)
                    
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
                        if let accessory = self.purchasableViewModel.getAccessoryViewModel() {
                            if accessory.isPeripheral {
                                self.peripheralAccessoryEquipSheetActive = true
                            } else {
                                self.accessorySelectionSheetActive = true
                            }
                        } else if self.purchasableViewModel.getArmorViewModel() != nil {
                            self.armorEquipSheetActive = true
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
                                guard self.purchasableViewModel.getAccessoryViewModel() != nil else {
                                    return
                                }
                                if let id = selection {
                                    // If nil, we're inserting to an empty accessory slot
                                    self.playerViewModel.unequipAccessory(id: id, cacheLocation: true)
                                }
                                self.purchasableViewModel.purchase(by: self.playerViewModel, amount: self.amount)
                            }
                    ))
                    .withInspectSheet(
                        isPresented: self.$peripheralAccessoryEquipSheetActive,
                        pageGeometry: self.pageGeometry,
                        content: AnyView(
                            EquipPeripheralAccessoryView(
                                playerViewModel: self.playerViewModel,
                                accessoryViewModel: purchasableViewModel.getAccessoryViewModel() ?? AccessoryViewModel(NoAccessory(type: .peripheral))
                            ) { confirmEquip in
                                self.peripheralAccessoryEquipSheetActive = false
                                guard self.purchasableViewModel.getAccessoryViewModel()?.isPeripheral ?? false else {
                                    return
                                }
                                // This is a buffer added - otherwise the sheet doesn't dismiss
                                // I presume because this function changes the content in the sheet, its dismissal doesn't trigger properly
                                // The delay isn't noticeable
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    if confirmEquip {
                                        self.purchasableViewModel.purchase(
                                            by: self.playerViewModel,
                                            amount: self.amount
                                        )
                                    }
                                }
                            }
                        )
                    )
                    .withInspectSheet(
                        isPresented: self.$armorEquipSheetActive,
                        pageGeometry: self.pageGeometry,
                        content: AnyView(
                            EquipArmorView(
                                playerViewModel: self.playerViewModel,
                                armorViewModel: self.purchasableViewModel.getArmorViewModel() ?? ArmorViewModel(NoArmor(type: .body))
                            ) { confirmEquip in
                                self.armorEquipSheetActive = false
                                guard self.purchasableViewModel.getArmorViewModel() != nil else {
                                    return
                                }
                                // This is a buffer added - otherwise the sheet doesn't dismiss
                                // I presume because this function changes the content in the sheet, its dismissal doesn't trigger properly
                                // The delay isn't noticeable
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    if confirmEquip {
                                        self.purchasableViewModel.purchase(
                                            by: self.playerViewModel,
                                            amount: self.amount
                                        )
                                    }
                                }
                            }
                        )
                    )
                }
                .padding(.horizontal, YonderCoreGraphics.innerPadding)
                .padding(.bottom, YonderCoreGraphics.innerPadding)
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
