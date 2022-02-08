//
//  NPCCardAndSheetView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import SwiftUI

struct NPCCardAndSheetView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var optionsSheetsStateManager: OptionsSheetsStateManager
    let pageGeometry: GeometryProxy
    
    var body: some View {
        Button {
            self.optionsSheetsStateManager.npcSheetBinding = true
        } label: {
            switch self.locationViewModel.type {
            case .none:
                EmptyCardView()
            case .hostile:
                FoeCardView(foeViewModel: self.locationViewModel.getFoeViewModel()!)
            case .challengeHostile:
                FoeCardView(foeViewModel: self.locationViewModel.getFoeViewModel()!)
            case .shop:
                ShopKeeperCardView(shopKeeperViewModel: self.locationViewModel.getInteractorViewModel() as! ShopKeeperViewModel)
            case .enhancer:
                EnhancerCardView(enhancerCardView: self.locationViewModel.getInteractorViewModel() as! EnhancerViewModel)
            case .restorer:
                RestorerCardView(restorerViewModel: self.locationViewModel.getInteractorViewModel() as! RestorerViewModel)
            case .quest:
                EmptyCardView()
            case .friendly:
                FriendlyCardView(friendlyCardView: self.locationViewModel.getInteractorViewModel() as! FriendlyViewModel)
            case .boss:
                FoeCardView(foeViewModel: self.locationViewModel.getFoeViewModel()!)
            }
        }
        .sheet(isPresented: self.$optionsSheetsStateManager.npcSheetBinding) {
            ZStack {
                Color.Yonder.backgroundMaxDepth
                    .ignoresSafeArea()
                
                Rectangle()
                    .stroke(Color.Yonder.border, lineWidth: YonderCoreGraphics.borderWidth)
                    .frame(
                        width: pageGeometry.size.width-YonderCoreGraphics.padding*4,
                        height: pageGeometry.size.height)
                
                Text(self.locationViewModel.typeAsString)
                    .foregroundColor(.white)
            }
            .onTapGesture {
                self.optionsSheetsStateManager.npcSheetBinding = false
            }
        }
    }
}
