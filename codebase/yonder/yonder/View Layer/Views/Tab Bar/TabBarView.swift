//
//  TabBarView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                PrimaryView()
                    .opacity(self.viewRouter.currentPage == .primary ? 1 : 0)
                
                InventoryView()
                    .opacity(self.viewRouter.currentPage == .inventory ? 1 : 0)
                
                MapView()
                    .opacity(self.viewRouter.currentPage == .map ? 1 : 0)
                
                SettingsView()
                    .opacity(self.viewRouter.currentPage == .settings ? 1 : 0)
            }
            
            HStack(spacing: 0) {
                TabBarIconView(
                    viewRouter: self.viewRouter,
                    correspondingPage: .primary,
                    icon: YonderIcon(image: YonderIcons.gameIcon),
                    text: Strings("tabBar.game").local)
                
                TabBarIconView(
                    viewRouter: self.viewRouter,
                    correspondingPage: .inventory,
                    icon: YonderIcon(image: YonderIcons.inventoryIcon),
                    text: Strings("tabBar.inventory").local)
                
                TabBarIconView(
                    viewRouter: self.viewRouter,
                    correspondingPage: .map,
                    icon: YonderIcon(image: YonderIcons.mapIcon),
                    text: Strings("tabBar.map").local)
                
                TabBarIconView(
                    viewRouter: self.viewRouter,
                    correspondingPage: .settings,
                    icon: YonderIcon(image: YonderIcons.settingsIcon),
                    text: Strings("tabBar.settings").local)
            }
            .frame(height: 55)
            .background(YonderColors.backgroundMaxDepth)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
