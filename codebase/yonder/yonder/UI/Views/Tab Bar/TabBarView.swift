//
//  TabBarView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var viewRounter: ViewRouter
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                OptionsView()
                    .opacity(self.viewRounter.currentPage == .options ? 1 : 0)
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
                    correspondingPage: .options,
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
            .frame(height: 55)
            .background(Color.Yonder.backgroundMaxDepth)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

class ViewRouter: ObservableObject {
    
    @Published private(set) var currentPage: Page = .options
    
    func switchPage(to page: Page) {
        self.currentPage = page
    }
    
}

enum Page {
    case options
    case inventory
    case map
    case settings
}
