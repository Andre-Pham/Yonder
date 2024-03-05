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
    private let baseRestorationAmount = Restorer.bundleSize
    
    var body: some View {
        YonderBorder4 {
            VStack {
                HStack {
                    YonderText(text: "\(Strings("button.restore").local):", size: .buttonBody)
                    
                    HStack {
                        YonderIcon(image: self.restorationOptionViewModel.image)
                        
                        IndicativeNumeralView(
                            original: self.baseRestorationAmount,
                            indicative: self.restorationOptionViewModel.getIndicativeRestoration(of: self.baseRestorationAmount, target: self.playerViewModel),
                            size: .buttonBody)
                    }
                    
                    Spacer()
                    
                    PriceTagButton(
                        price: self.restorationOptionViewModel.getBundlePrice(),
                        indicativePrice: self.playerViewModel.getIndicativePrice(
                            from: self.restorationOptionViewModel.getBundlePrice()
                        )
                    ) {
                        self.restorationOptionViewModel.restore(
                            amount: self.baseRestorationAmount,
                            to: self.playerViewModel
                        )
                    }
                    .disabledWhen(
                        self.restorationOptionViewModel.restoreIsDisabled(
                            playerViewModel: self.playerViewModel,
                            amount: self.baseRestorationAmount
                        )
                    )
                }
            }
            .padding(YonderCoreGraphics.innerPadding)
        }
    }
}

struct PurchaseRestorationButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            PurchaseRestorationButton(
                playerViewModel: PreviewObjects.playerViewModel,
                restorationOptionViewModel: PreviewObjects.restoreOptionViewModel)
        }
    }
}
