//
//  GameOverView.swift
//  yonder
//
//  Created by Andre Pham on 27/3/2024.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject private var appState: AppStateManager
    @StateObject private var gameOverManager = GameOverManager()
    @State private var backgroundOpacity: Double = 0.0
    @State private var staticViewsOpacity: Double = 0.0
    @State private var interactiveViewsOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
                // Disable the user interacting with the game beneath
                .allowsHitTesting(true)
                .opacity(self.backgroundOpacity)
            
            VStack(spacing: 32) {
                YonderText(text: Strings("gameOverMenu.title").local, size: .title2)
                    .opacity(self.staticViewsOpacity)
                
                YonderButton(text: Strings("button.mainMenu").local) {
                    self.appState.setMenuShowing(to: true)
                }
                .opacity(self.interactiveViewsOpacity)
                
                #if DEBUG
                YonderButton(text: Strings("button.resume").local) {
                    self.gameOverManager.continueAfterGameOver()
                }
                .opacity(self.interactiveViewsOpacity)
                #endif
            }
        }
        .onChange(of: self.gameOverManager.isGameOver) { wasGameOver, isGameOver in
            if isGameOver {
                self.reactToGameOver(animate: true)
            } else {
                self.hideView()
            }
        }
        .onAppear {
            if self.gameOverManager.isGameOver {
                self.reactToGameOver(animate: false)
            }
        }
    }
    
    func reactToGameOver(animate: Bool) {
        if animate {
            withAnimation(.linear(duration: 3.0)) {
                self.backgroundOpacity = 0.8
                self.staticViewsOpacity = 1.0
            } completion: {
                withAnimation(.linear(duration: 0.5)) {
                    self.interactiveViewsOpacity = 1.0
                }
            }
        } else {
            self.backgroundOpacity = 0.8
            self.staticViewsOpacity = 1.0
            self.interactiveViewsOpacity = 1.0
        }
    }
    
    func hideView() {
        self.backgroundOpacity = 0.0
        self.staticViewsOpacity = 0.0
        self.interactiveViewsOpacity = 0.0
    }
    
}

#Preview {
    PreviewContentView {
        VStack(spacing: 32) {
            YonderText(text: "Game Over", size: .title2)
            
            YonderButton(text: "Main Menu") { }
        }
    }
}
