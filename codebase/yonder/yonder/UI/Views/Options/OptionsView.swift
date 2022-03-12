//
//  OptionsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionsView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    @EnvironmentObject private var travelStateManager: TravelStateManager
    @ObservedObject private var playerViewModel: PlayerViewModel
    @ObservedObject private var optionsStateManager: OptionsStateManager
    @StateObject private var optionsSheetsStateManager = OptionsSheetsStateManager()
    
    init() {
        let playerViewModel = gameManager.playerVM
        
        self.playerViewModel = playerViewModel
        self.optionsStateManager = OptionsStateManager(playerViewModel: playerViewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    LocationView(locationViewModel: self.playerViewModel.locationViewModel)
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        PlayerCardAndSheetView(
                            playerViewModel:
                                self.playerViewModel,
                            optionsSheetsStateManager:
                                self.optionsSheetsStateManager, pageGeometry: geo)
                        
                        NPCCardAndSheetView(
                            locationViewModel:
                                self.playerViewModel.locationViewModel,
                            optionsSheetsStateManager:
                                self.optionsSheetsStateManager,
                            pageGeometry: geo)
                        
                    }
                    .padding(.leading, YonderCoreGraphics.padding)
                    .padding(.trailing, YonderCoreGraphics.padding)
                    .frame(maxWidth: .infinity)
                    .frame(height: geo.size.width/2 - YonderCoreGraphics.padding*1.5)
                    
                    YonderText(text: self.optionsStateManager.optionHeader, size: .title4)
                    
                    if self.optionsStateManager.showOptions {
                        LazyVGrid(columns: self.optionsStateManager.optionColumns, spacing: YonderCoreGraphics.padding) {
                            if optionsStateManager.weaponOptionActive {
                                Button {
                                    self.optionsStateManager.weaponOptionSelected()
                                } label: {
                                    OptionView(title: "Select \(Term.weapon.capitalized)", geometry: geo, image: YonderImages.weaponOptionIcon)
                                }
                            }
                            
                            if optionsStateManager.potionOptionActive {
                                Button {
                                    self.optionsStateManager.potionOptionSelected()
                                } label: {
                                    OptionView(title: "Select \(Term.potion.capitalized)", geometry: geo, image: YonderImages.missingIcon)
                                }
                            }
                            
                            if self.optionsStateManager.offerOptionActive {
                                Button {
                                    self.optionsStateManager.offerOptionSelected()
                                } label: {
                                    OptionView(title: "View \(Term.offers.capitalized)", geometry: geo, image: YonderImages.missingIcon)
                                }
                            }
                            
                            if self.optionsStateManager.travelOptionActive {
                                Button {
                                    self.optionsStateManager.travelOptionSelected(viewRouter: self.viewRouter, travelStateManager: self.travelStateManager)
                                } label: {
                                    OptionView(title: Term.travel.capitalized, geometry: geo, image: YonderImages.missingIcon)
                                }
                            }
                        }
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    }
                    
                    if self.optionsStateManager.activeActions.isActive {
                        VStack {
                            YonderWideButton(text: "Back") {
                                self.optionsStateManager.closeActions()
                            }
                            
                            if self.optionsStateManager.weaponActionsActive.isActive {
                                ForEach(self.playerViewModel.weaponViewModels, id: \.id) { weaponViewModel in
                                    UseWeaponButton(
                                        playerViewModel: self.playerViewModel,
                                        weaponViewModel: weaponViewModel)
                                }
                            }
                            
                            if self.optionsStateManager.potionActionsActive.isActive {
                                ForEach(self.playerViewModel.potionViewModels, id: \.id) { potionViewModel in
                                    UsePotionButton(
                                        playerViewModel: self.playerViewModel,
                                        potionViewModel: potionViewModel)
                                }
                            }
                            
                            if self.optionsStateManager.offerActionsActive.isActive {
                                if let friendlyViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? FriendlyViewModel {
                                    ForEach(friendlyViewModel.offers, id: \.id) { offer in
                                        YonderMultilineWideButton(text: [offer.name, offer.description]) {
                                            friendlyViewModel.acceptOffer(offer, player: self.playerViewModel)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    }
                }
            }
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            OptionsView()
        }
    }
}
