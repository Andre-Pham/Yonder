//
//  OptionsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionsView: View {
    let optionColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @StateObject private var player = PlayerPresenter(GAME.player)
    
    @State private var optionHeader = "[Your Options]"
    @State private var showOptions = true
    @State private var showEngageCategories = false
    @State private var showWeaponActions = false
    
    @State private var showingPlayerSheet = false
    @State private var showingNPCSheet = false
    
    var body: some View {
        GeometryReader { geo in
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    LocationView(location: player.locationPresenter)
                        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        Button {
                            showingPlayerSheet.toggle()
                        } label: {
                            PlayerCardView(player: player)
                                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        }
                        .sheet(isPresented: $showingPlayerSheet) {
                            Text("Wow!")
                        }
                        
                        Button {
                            showingNPCSheet.toggle()
                        } label: {
                            EnemyView()
                                .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                        }
                        .sheet(isPresented: $showingNPCSheet) {
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
                                showingNPCSheet = false
                            }
                        }
                        
                    }
                    .padding(.leading, YonderCoreGraphics.padding)
                    .padding(.trailing, YonderCoreGraphics.padding)
                    .frame(maxWidth: .infinity)
                    .frame(height: geo.size.width/2 - YonderCoreGraphics.padding*1.5)
                    
                    YonderText(text: optionHeader, size: .title4)
                    
                    if showOptions {
                        LazyVGrid(columns: optionColumns, spacing: YonderCoreGraphics.padding) {
                            // Normally it's just "if location.isHostile, show the Engage option"
                            ForEach(0..<5) { _ in
                                Button {
                                    player.equipArmor(Armors.newTestBodyArmor())
                                    showOptions.toggle()
                                    showEngageCategories.toggle()
                                    optionHeader = "[Engage Options]"
                                } label: {
                                    EngageOptionView()
                                        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                                        .frame(width: geo.size.width/3 - YonderCoreGraphics.padding*4/3, height: geo.size.width/3 - YonderCoreGraphics.padding*2)
                                }
                            }
                        }
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    }
                    
                    if showEngageCategories {
                        let engageCategoryViews = [
                            EngageCategoryView(title: "Weapons"),
                            EngageCategoryView(title: "Potions")
                        ]
                        
                        VStack {
                            ForEach(engageCategoryViews) { view in
                                Button {
                                    showOptions.toggle()
                                    showEngageCategories.toggle()
                                    optionHeader = "[Your Options]"
                                } label: {
                                    view
                                        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                }
                            }
                        }
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    }
                }
            }
            
            Color.Yonder.backgroundMaxDepth
                .frame(
                    width: geo.size.width,
                    height: geo.safeAreaInsets.top,
                    alignment: .top)
                .ignoresSafeArea()
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
