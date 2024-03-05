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
    
    // Important:
    // The following properties need to be maintained as @StateObjects (not @ObservableObjects)
    // @StateObjects are NOT reinstantiated every time the view is redrawn (UNLIKE @ObservableObjects)
    // If these become @ObservableObjects, not only are they needlessly recreated every draw, every subview that points to their instance to create a new object ends up pointing to the wrong object upon this being redrawn (see LocationView)
    
    @StateObject private var playerViewModel: PlayerViewModel = GameManager.instance.playerVM
    @StateObject private var optionsStateManager: OptionsStateManager = OptionsStateManager(playerViewModel: GameManager.instance.playerVM)
    @StateObject private var optionsSheetsStateManager = OptionsSheetsStateManager()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    LocationView(
                        locationViewModel: self.playerViewModel.locationViewModel,
                        optionsStateManager: self.optionsStateManager
                    )
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        PlayerCardButton(
                            playerViewModel: 
                                self.playerViewModel,
                            optionsSheetsStateManager: 
                                self.optionsSheetsStateManager,
                            pageGeometry: geo
                        )
                        
                        NPCCardButton(
                            locationViewModel: 
                                self.playerViewModel.locationViewModel,
                            optionsSheetsStateManager:
                                self.optionsSheetsStateManager,
                            pageGeometry: geo
                        )
                        
                    }
                    .padding(.horizontal, YonderCoreGraphics.padding)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geo.size.width/2 - YonderCoreGraphics.padding*1.5)
                    
                    YonderText(text: self.optionsStateManager.optionHeader, size: .title5)
                    
                    if self.optionsStateManager.showOptions {
                        OptionsView(
                            playerViewModel: self.playerViewModel,
                            optionsStateManager: self.optionsStateManager,
                            pageGeometry: geo)
                        .padding(.horizontal, YonderCoreGraphics.padding)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    if self.optionsStateManager.showActions {
                        ActionsView(
                            playerViewModel: self.playerViewModel,
                            optionsStateManager: self.optionsStateManager,
                            pageGeometry: geo)
                        .padding(.horizontal, YonderCoreGraphics.padding)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .padding(.bottom, 100)
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
