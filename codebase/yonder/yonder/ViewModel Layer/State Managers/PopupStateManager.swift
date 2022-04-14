//
//  PopupStateManager.swift
//  yonder
//
//  Created by Andre Pham on 15/4/2022.
//

import Foundation
import SwiftUI

class PopupStateManager: ObservableObject {
    
    @Published private(set) var isShowing = false
    private var popupQueueSize = 0 {
        didSet {
            print(self.popupQueueSize)
            if oldValue < self.popupQueueSize {
                if self.popupQueueSize == 1 {
                    self.startPopup()
                }
                else if self.popupQueueSize > 1 {
                    self.restartPopup()
                }
            }
        }
    }
    // Batches track the groups of activations/restarts between deactivations
    // This way, if we deactivate and set the queue back to 0, the queue doesn't go into the negatives from previous calls
    private var batch = 0
    
    func activatePopup() {
        self.popupQueueSize += 1
    }
    
    func deactivatePopup() {
        self.isShowing = false
        self.popupQueueSize = 0
        self.batch += 1
    }
    
    // Short = 1.5
    // Long = 2
    
    private func startPopup() {
        self.isShowing = true
        let batch = self.batch
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if batch == self.batch {
                self.popupQueueSize -= 1
                if self.popupQueueSize == 0 {
                    self.isShowing = false
                }
            }
        }
    }
    
    private func restartPopup() {
        self.isShowing = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.startPopup()
        }
    }
    
}
