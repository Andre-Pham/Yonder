//
//  EnhancerCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct EnhancerCardView: View {
    @ObservedObject var enhancerCardView: EnhancerViewModel
    
    var body: some View {
        YonderText(text: "Temp", size: .cardBody)
    }
}

