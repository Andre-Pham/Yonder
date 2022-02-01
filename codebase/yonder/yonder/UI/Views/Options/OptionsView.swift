//
//  OptionsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionsView: View {
    @ObservedObject private var playerViewModel: PlayerViewModel
    @ObservedObject private var optionsStateManager: OptionsStateManager
    
    init() {
        let playerViewModel = PlayerViewModel(GAME.player)
        
        self.playerViewModel = playerViewModel
        self.optionsStateManager = OptionsStateManager(playerViewModel: playerViewModel)
    }
    
    @State private var showingPlayerSheet = false
    @State private var showingNPCSheet = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    LocationView(locationViewModel: self.playerViewModel.locationViewModel)
                        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        Button {
                            self.showingPlayerSheet.toggle()
                        } label: {
                            PlayerCardView(playerViewModel: self.playerViewModel)
                                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        }
                        .sheet(isPresented: self.$showingPlayerSheet) {
                            Text("Wow!")
                        }
                        
                        Button {
                            showingNPCSheet.toggle()
                        } label: {
                            EnemyCardView()
                                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        }
                        .sheet(isPresented: self.$showingNPCSheet) {
                            ZStack {
                                Color.Yonder.backgroundMaxDepth
                                    .ignoresSafeArea()
                                
                                Rectangle()
                                    .stroke(Color.Yonder.border, lineWidth: YonderCoreGraphics.borderWidth)
                                    .frame(
                                        width: geo.size.width-YonderCoreGraphics.padding*4,
                                        height: geo.size.height)
                                
                                Text(":3")
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                self.showingNPCSheet = false
                            }
                        }
                        
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
                                    OptionView(title: "Select Weapon", geometry: geo)
                                }
                            }
                            
                            if self.optionsStateManager.travelOptionActive {
                                Button {
                                    self.optionsStateManager.travelOptionSelected()
                                } label: {
                                    OptionView(title: "Travel", geometry: geo)
                                }
                                .sheet(isPresented: self.$optionsStateManager.travelActionsActive.isActive) {
                                    MapView()
                                }
                            }
                        }
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    }
                    
                    if self.optionsStateManager.activeActions.isActive {
                        VStack {
                            Button {
                                self.optionsStateManager.closeActions()
                            } label: {
                                YonderWideButtonLabel(text: "Back")
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
        OptionsView()
    }
}
