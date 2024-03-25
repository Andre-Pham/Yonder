//
//  MainMenuView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject private var appState: AppStateManager
    @State private var showingClassSelection = false
    @State private var isLoading = false
    @State private var showingFailAlert = false
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                
                YonderText(text: Strings("gameName").local, size: .title1)
                
                VStack(spacing: 30) {
                    YonderButton(text: Strings("mainMenu.newGame").local) {
                        self.toggleClassSelectionMenu()
                    }
                    
                    YonderButton(text: Strings("mainMenu.resumeGame").local) {
                        self.resumeGame()
                    }
                }
                .padding(40)
                
                Spacer()
                Spacer()
            }
            .foregroundColor(YonderColors.textMaxContrast)
            
            ZStack { // Required to display exit animation
                if self.showingClassSelection {
                    ClassSelectView(isShowing: self.$showingClassSelection) { selection in
                        self.startNewGame(for: selection)
                    } onCancel: {
                        self.toggleClassSelectionMenu()
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            
            if self.isLoading {
                DotsLoadingScreen()
            }
        }
        .alert(isPresented: self.$showingFailAlert) {
            Alert(
                title: Text(Strings("alert.title.failed").local),
                dismissButton: .default(Text(Strings("alert.button.dismiss").local))
            )
        }
    }
    
    func startNewGame(for playerClass: PlayerClassOption) {
        self.isLoading = true
        DispatchQueue.global().async {
            Session.instance.startNewGame(playerClass: playerClass)
            DispatchQueue.main.async {
                self.isLoading = false
                self.appState.setMenuShowing(to: false)
            }
        }
    }
    
    func resumeGame() {
        self.isLoading = true
        DispatchQueue.global().async {
            let loadSuccessful = Session.instance.loadGame()
            DispatchQueue.main.async {
                self.isLoading = false
                if loadSuccessful {
                    self.appState.setMenuShowing(to: false)
                } else {
                    self.showingFailAlert = true
                }
            }
        }
    }
    
    func toggleClassSelectionMenu() {
        withAnimation(.easeOut) {
            self.showingClassSelection.toggle()
        }
    }
    
}
