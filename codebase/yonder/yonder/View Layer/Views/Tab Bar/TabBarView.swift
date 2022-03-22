//
//  TabBarView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var viewRounter: ViewRouter
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                OptionsView()
                    .opacity(self.viewRounter.currentPage == .options ? 1 : 0)
                
                if self.viewRounter.currentPage == .inventory {
                    // Other views we adjust the opacity to hide the view while maintaining state
                    // We want to reload the inventory view every time we open it
                    // Inventory view has to manage dynamic inspect sheets, for example, player weapons
                    // Adding (for example) weapons in other tabs will modify the state of the inventory view's sheets
                    // This is fine, except (for some reason) it breaks the animation for all sheets until inventory view is loaded in as the currently active view
                    // To demonstate this:
                    // 1. Maintain inventory view's state using opacity to dismiss it (like other views)
                    // 2. Purchase/obtain a weapon in option view
                    // 3. Open any inspect sheet in option view
                    InventoryView()
                }
                
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
                    text: Term.options.capitalized)
                
                TabBarIconView(
                    viewRounter: self.viewRounter,
                    correspondingPage: .inventory,
                    icon: YonderIcon(image: YonderImages.inventoryIcon),
                    text: Term.inventory.capitalized)
                
                TabBarIconView(
                    viewRounter: self.viewRounter,
                    correspondingPage: .map,
                    icon: YonderIcon(image: YonderImages.mapIcon),
                    text: Term.map.capitalized)
                
                TabBarIconView(
                    viewRounter: self.viewRounter,
                    correspondingPage: .settings,
                    icon: YonderIcon(image: YonderImages.settingsIcon),
                    text: Term.settings.capitalized)
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
