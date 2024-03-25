//
//  AppStateManager.swift
//  yonder
//
//  Created by Andre Pham on 26/3/2024.
//

import Foundation
import SwiftUI

class AppStateManager: ObservableObject {
    
    @Published private(set) var menuShowing = true
    
    init() { }
    
    func setMenuShowing(to showing: Bool) {
        self.menuShowing = showing
    }
    
}
