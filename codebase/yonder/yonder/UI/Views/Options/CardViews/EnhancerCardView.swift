//
//  EnhancerCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct EnhancerCardView: View {
    @ObservedObject var enhancerViewModel: EnhancerViewModel
    
    var body: some View {
        CardBody(name: self.enhancerViewModel.name) {
            
        }
    }
}

