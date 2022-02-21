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
                                    self.playerViewModel.equipArmor(Armors.newTestBodyArmor())
                                } label: {
                                    OptionView(title: "Select \(Term.weapon.capitalized)", geometry: geo)
                                }
                            }
                            
                            if self.optionsStateManager.travelOptionActive {
                                Button {
                                    self.optionsStateManager.travelOptionSelected(viewRouter: self.viewRouter, travelStateManager: self.travelStateManager)
                                } label: {
                                    OptionView(title: Term.travel.capitalized, geometry: geo)
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
                                    YonderMultilineWideButton(
                                        text: [
                                            "\(weaponViewModel.name)",
                                            "\(weaponViewModel.damage) \(Term.damage.capitalized)",
                                            "\(weaponViewModel.remainingUses) \(Term.remainingUses.capitalized)"
                                        ],
                                        alignment: .leading) {
                                            self.playerViewModel.use(weaponViewModel: weaponViewModel)
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
