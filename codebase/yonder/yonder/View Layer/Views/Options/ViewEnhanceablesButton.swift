//
//  ViewEnhanceablesButton.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import SwiftUI

struct ViewEnhanceablesButton: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var enhanceOfferViewModel: EnhanceOfferViewModel
    let pageGeometry: GeometryProxy
    @ObservedObject var purchaseEnhanceOfferStateManager: PurchaseEnhanceOfferStateManager
    @State private var optionsSheetActive = false
    @StateObject private var popupStateManager = PopupStateManager()
    
    var isDisabled: Bool {
        return !self.enhanceOfferViewModel.canBeAfforded(by: self.playerViewModel) || enhanceOfferViewModel.getEnhanceableInfos(playerViewModel: self.playerViewModel).isEmpty
    }
    
    init(playerViewModel: PlayerViewModel, enhanceOfferViewModel: EnhanceOfferViewModel, pageGeometry: GeometryProxy) {
        self.playerViewModel = playerViewModel
        self.enhanceOfferViewModel = enhanceOfferViewModel
        self.pageGeometry = pageGeometry
        self.purchaseEnhanceOfferStateManager = PurchaseEnhanceOfferStateManager(offerCount: enhanceOfferViewModel.getEnhanceableInfos(playerViewModel: playerViewModel).count)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            YonderText(text: self.enhanceOfferViewModel.name, size: .buttonBody)
            
            YonderText(text: self.enhanceOfferViewModel.description, size: .buttonBodySubscript)
            
            HStack(spacing: YonderCoreGraphics.padding) {
                PriceTagView(price: self.enhanceOfferViewModel.price, indicativePrice: self.playerViewModel.getIndicativePrice(from: self.enhanceOfferViewModel.price))
                
                YonderWideButton(text: Strings.Button.ViewOptions.local) {
                    self.optionsSheetActive = true
                }
                .disabledWhen(self.isDisabled)
            }
        }
        .yonderWideBorder()
        .sheet(isPresented: self.$optionsSheetActive) {
            InspectSheet(pageGeometry: self.pageGeometry) {
                VStack {
                    PlayerCardView(playerViewModel: self.playerViewModel, resizeToFit: false)
                    
                    WidePriceTagView(price: self.enhanceOfferViewModel.price, indicativePrice: self.playerViewModel.getIndicativePrice(from: self.enhanceOfferViewModel.price), text: Strings.Inspect.EnhanceOffers.PriceTagSuffix.local)
                    
                    SurroundingBrackets(bracket: "[", size: .title4) {
                        YonderText(text: Strings.Inspect.EnhanceOffers.Header.local, size: .title4)
                    }
                    
                    ForEach(Array(zip(enhanceOfferViewModel.getEnhanceableInfos(playerViewModel: self.playerViewModel).indices, enhanceOfferViewModel.getEnhanceableInfos(playerViewModel: self.playerViewModel))), id: \.1.id) { index, enhanceInfoViewModel in
                        
                        YonderExpandableWideButtonBody(isExpanded: self.$purchaseEnhanceOfferStateManager.purchaseButtonActiveBindings[index]) {
                            YonderText(text: enhanceInfoViewModel.name, size: .buttonBody)
                        } expandedContent: {
                            YonderWideButton(text: Strings.Button.Purchase.local) {
                                self.enhanceOfferViewModel.accept(playerViewModel: self.playerViewModel, enhanceableID: enhanceInfoViewModel.id)
                                self.popupStateManager.activatePopup()
                            }
                            .disabledWhen(self.isDisabled)
                        }
                    }
                }
            }
            .onTapGesture {
                self.optionsSheetActive = false
            }
            .withFeedbackPopup(text: Strings.Feedback.Enhanced.local, padding: YonderCoreGraphics.padding*3, popupStateManager: self.popupStateManager)
        }
    }
}

struct ViewEnhanceablesButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                ViewEnhanceablesButton(
                    playerViewModel: PreviewObjects.playerViewModel,
                    enhanceOfferViewModel: PreviewObjects.enhanceOfferViewModel,
                    pageGeometry: geo
                )
            }
        }
    }
}
