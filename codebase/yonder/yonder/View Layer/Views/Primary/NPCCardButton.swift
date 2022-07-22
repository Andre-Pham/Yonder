//
//  NPCCardButton.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import SwiftUI

struct NPCCardButton: View {
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
                EnhancerCardView(enhancerViewModel: self.locationViewModel.getInteractorViewModel() as! EnhancerViewModel)
            case .restorer:
                RestorerCardView(restorerViewModel: self.locationViewModel.getInteractorViewModel() as! RestorerViewModel)
            case .quest:
                EmptyCardView()
            case .friendly:
                FriendlyCardView(friendlyViewModel: self.locationViewModel.getInteractorViewModel() as! FriendlyViewModel)
            case .boss:
                FoeCardView(foeViewModel: self.locationViewModel.getFoeViewModel()!)
            case .bridge:
                let (area1ViewModel, area2ViewModel) = self.locationViewModel.getBridgeConnectedAreaViewModels()!
                BridgeCardView(area1ViewModel: area1ViewModel, area2ViewModel: area2ViewModel)
            }
        }
        .withInspectSheet(isPresented: self.$optionsSheetsStateManager.npcSheetBinding, pageGeometry: self.pageGeometry, content: AnyView(
            self.getInspectView()
        ))
    }
    
    func getInspectView() -> some View {
        switch self.locationViewModel.type {
        case .none:
            return AnyView(EmptyView())
        case .hostile:
            return AnyView(HostileInspectView(foeViewModel: self.locationViewModel.getFoeViewModel()!))
        case .challengeHostile:
            return AnyView(ChallengeHostileInspectView(foeViewModel: self.locationViewModel.getFoeViewModel()!))
        case .shop:
            return AnyView(ShopKeeperInspectView(shopkeeperViewModel: self.locationViewModel.getInteractorViewModel() as! ShopKeeperViewModel))
        case .enhancer:
            return AnyView(EnhancerInspectView(enhancerViewModel: self.locationViewModel.getInteractorViewModel() as! EnhancerViewModel))
        case .restorer:
            return AnyView(RestorerInspectView(restorerViewModel: self.locationViewModel.getInteractorViewModel() as! RestorerViewModel))
        case .quest:
            return AnyView(EmptyView())
        case .friendly:
            return AnyView(FriendlyInspectView(friendlyViewModel: self.locationViewModel.getInteractorViewModel() as! FriendlyViewModel))
        case .boss:
            return AnyView(BossInspectView(foeViewModel: self.locationViewModel.getFoeViewModel()!))
        case .bridge:
            let (location1ViewModel, location2ViewModel) = self.locationViewModel.getBridgeConnectedLocationViewModels()!
            return AnyView(BridgeInspectView(location1ViewModel: location1ViewModel, location2ViewModel: location2ViewModel))
        }
    }
    
}
