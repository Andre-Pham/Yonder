//
//  TabBarView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @ObservedObject var viewRounter: ViewRouter
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                OptionsView()
                    .opacity(self.viewRounter.currentPage == .game ? 1 : 0)
                InventoryView()
                    .opacity(self.viewRounter.currentPage == .inventory ? 1 : 0)
                MapView()
                    .opacity(self.viewRounter.currentPage == .map ? 1 : 0)
                SettingsView()
                    .opacity(self.viewRounter.currentPage == .settings ? 1 : 0)
            }
            
            HStack(spacing: 0) {
                TabBarIconView(
                    viewRounter: self.viewRounter,
                    correspondingPage: .game,
                    icon: YonderIcon(image: YonderImages.gameIcon),
                    text: "Game")
                
                TabBarIconView(
                    viewRounter: self.viewRounter,
                    correspondingPage: .inventory,
                    icon: YonderIcon(image: YonderImages.inventoryIcon),
                    text: "Inventory")
                
                TabBarIconView(
                    viewRounter: self.viewRounter,
                    correspondingPage: .map,
                    icon: YonderIcon(image: YonderImages.mapIcon),
                    text: "Map")
                
                TabBarIconView(
                    viewRounter: self.viewRounter,
                    correspondingPage: .settings,
                    icon: YonderIcon(image: YonderImages.settingsIcon),
                    text: "Settings")
            }
            .frame(height: 50)
            .background(Color.Yonder.backgroundMaxDepth)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .game
    
}

enum Page {
    case game
    case inventory
    case map
    case settings
}
