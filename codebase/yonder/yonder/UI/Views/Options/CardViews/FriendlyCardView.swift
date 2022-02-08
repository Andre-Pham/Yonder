//
//  FriendlyCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct FriendlyCardView: View {
    @ObservedObject var friendlyCardView: FriendlyViewModel
    
    var body: some View {
        YonderText(text: "Temp", size: .cardBody)
    }
}

