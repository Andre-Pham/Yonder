//
//  LocationIconView.swift
//  yonder
//
//  Created by Andre Pham on 16/1/2022.
//

import Foundation
import SwiftUI

struct LocationIconView: View {
    let locationType: LocationType
    
    var body: some View {
        switch locationType {
        case .none: return YonderIcon(image: YonderImages.missingIcon)
        case .hostile: return YonderIcon(image: YonderImages.hostileIcon)
        case .challengeHostile: return YonderIcon(image: YonderImages.challengeHostileIcon)
        case .shop: return YonderIcon(image: YonderImages.shopIcon)
        case .enhancer: return YonderIcon(image: YonderImages.enhancerIcon)
        case .restorer: return YonderIcon(image: YonderImages.restorerIcon)
        case .quest: return YonderIcon(image: YonderImages.missingIcon)
        case .friendly: return YonderIcon(image: YonderImages.friendlyIcon)
        case .boss: return YonderIcon(image: YonderImages.missingIcon)
        case .bridge: return YonderIcon(image: YonderImages.warpIcon)
        }
    }
}
