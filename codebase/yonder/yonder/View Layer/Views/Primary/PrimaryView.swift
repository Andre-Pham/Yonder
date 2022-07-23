//
//  PrimaryView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct PrimaryView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    @EnvironmentObject private var travelStateManager: TravelStateManager
    @ObservedObject private var playerViewModel: PlayerViewModel
    @ObservedObject private var optionsStateManager: OptionsStateManager
    @StateObject private var optionsSheetsStateManager = OptionsSheetsStateManager()
    
    init() {
        let playerViewModel = GameManager.instance.playerVM
        
        self.playerViewModel = playerViewModel
        self.optionsStateManager = OptionsStateManager(playerViewModel: playerViewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    LocationView(locationViewModel: self.playerViewModel.locationViewModel)
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        PlayerCardButton(
                            playerViewModel:
                                self.playerViewModel,
                            optionsSheetsStateManager:
                                self.optionsSheetsStateManager, pageGeometry: geo)
                        
                        NPCCardButton(
                            locationViewModel:
                                self.playerViewModel.locationViewModel,
                            optionsSheetsStateManager:
                                self.optionsSheetsStateManager,
                            pageGeometry: geo)
                        
                    }
                    .padding(.horizontal, YonderCoreGraphics.padding)
                    .frame(maxWidth: .infinity)
                    .frame(height: geo.size.width/2 - YonderCoreGraphics.padding*1.5)
                    
                    YonderText(text: self.optionsStateManager.optionHeader, size: .title4)
                    
                    if self.optionsStateManager.showOptions {
                        OptionsView(
                            playerViewModel: self.playerViewModel,
                            optionsStateManager: self.optionsStateManager,
                            pageGeometry: geo)
                        .padding(.horizontal, YonderCoreGraphics.padding)
                    }
                    
                    if self.optionsStateManager.activeActions.isActive {
                        ActionsView(
                            playerViewModel: self.playerViewModel,
                            optionsStateManager: self.optionsStateManager,
                            pageGeometry: geo)
                        .padding(.horizontal, YonderCoreGraphics.padding)
                    }
                }
            }
        }
    }
}

struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            PrimaryView()
        }
    }
}
