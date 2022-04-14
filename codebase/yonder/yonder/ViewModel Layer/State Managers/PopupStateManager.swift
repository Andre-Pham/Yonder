//
//  PopupStateManager.swift
//  yonder
//
//  Created by Andre Pham on 15/4/2022.
//

import Foundation
import SwiftUI

/// Manages the state of whether a popup is showing or not.
/// Maintains a "queue" of popups and handles the restarting behaviour of popups. This way, a popup being activated while being shown doesn't just close as if it was never activated at all.
class PopupStateManager: ObservableObject {
    
    enum PopupDuration: Double {
        case short = 1.5
        case long = 2.0
    }
    
    @Published private(set) var isShowing = false
    private var popupQueueSize = 0 {
        didSet {
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
    public let transitionDuration = 0.2
    public let popupDuration: Double
    
    init(popupDuration: PopupDuration = .short) {
        self.popupDuration = popupDuration.rawValue
    }
    
    func activatePopup() {
        self.popupQueueSize += 1
    }
    
    func deactivatePopup() {
        self.isShowing = false
        self.popupQueueSize = 0
        self.batch += 1
    }
    
    private func startPopup() {
        self.isShowing = true
        let batch = self.batch
        DispatchQueue.main.asyncAfter(deadline: .now() + self.popupDuration) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + self.transitionDuration) {
            self.startPopup()
        }
    }
    
}
