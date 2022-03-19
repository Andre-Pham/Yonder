//
//  OptionsSheetsStateManager.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import Combine

class OptionsSheetsStateManager: ObservableObject {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var playerSheetBinding: Bool = false
    @Published var npcSheetBinding: Bool = false
    
}
