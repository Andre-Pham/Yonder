//
//  RestorerCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct RestorerCardView: View {
    @ObservedObject var restorerViewModel: RestorerViewModel
    
    var body: some View {
        CardBody(name: self.restorerViewModel.name) {
            
        }
    }
}

