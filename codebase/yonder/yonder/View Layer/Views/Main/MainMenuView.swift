//
//  MainMenuView.swift
//  yonder
//
//  Created by Andre Pham on 21/1/2022.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    @Binding var showingMenu: Bool
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
                        self.showingClassSelection = true
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
            
            if self.showingClassSelection {
                ClassSelectView(isShowing: self.$showingClassSelection) { selection in
                    self.startNewGame(for: selection)
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
                self.showingMenu.toggle()
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
                    self.showingMenu.toggle()
                } else {
                    self.showingFailAlert = true
                }
            }
        }
    }
    
}
