//
//  ShopKeeperCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct ShopKeeperCardView: View {
    @ObservedObject var shopKeeperViewModel: ShopKeeperViewModel
    
    var body: some View {
        CardBody(name: self.shopKeeperViewModel.name) {
            CardInteractorTypeView()
        }
    }
}
