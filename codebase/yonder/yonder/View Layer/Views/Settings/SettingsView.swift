//
//  SettingsView.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppStateManager
    @State private var isSaving = false
    @State private var saveOutcomeColor: Color = .clear
    @State private var saveOutcome: String? = nil
    @State private var lastSaveID: UUID? = nil
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .center, spacing: YonderCoreGraphics.padding) {
                    YonderText(text: Strings("settings.title").local, size: .title2)
                    
                    Color.clear
                        .frame(width: 10, height: 30)
                    
                    YonderButton(text: Strings("button.save").local) {
                        self.saveGame()
                    }
                    
                    YonderButton(text: Strings("button.exitToMenu").local) {
                        self.saveGame() {
                            self.appState.setMenuShowing(to: true)
                        }
                    }
                    
                    if self.isSaving {
                        DotsLoadingText(text: Strings("persistence.saving").local, size: .cardBody)
                    }
                    
                    if let saveOutcome {
                        YonderText(
                            text: saveOutcome,
                            size: .cardBody,
                            color: self.saveOutcomeColor
                        )
                        .transition(.asymmetric(insertion: .identity, removal: .opacity))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, geo.size.height/6.0)
                .padding(.horizontal)
            }
        }
    }
    
    func saveGame(onSuccess: (() -> Void)? = nil) {
        guard !self.isSaving else {
            return
        }
        self.saveOutcome = nil
        self.isSaving = true
        DispatchQueue.global().async {
            let successful = Session.instance.saveGame()
            DispatchQueue.main.async {
                self.isSaving = false
                if successful {
                    self.saveOutcomeColor = YonderColors.success
                    self.saveOutcome = Strings("persistence.saveSuccessfulFeedback").local
                    onSuccess?()
                } else {
                    self.saveOutcomeColor = YonderColors.failure
                    self.saveOutcome = Strings("persistence.saveFailureFeedback").local
                }
                let saveID = UUID()
                self.lastSaveID = saveID
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if self.lastSaveID == saveID || self.lastSaveID == nil {
                        withAnimation {
                            self.saveOutcome = nil
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    PreviewContentView {
        SettingsView()
    }
}
