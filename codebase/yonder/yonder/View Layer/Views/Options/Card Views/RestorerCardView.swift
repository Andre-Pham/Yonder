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
            CardInteractorTypeView()
        }
    }
}

struct RestorerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            RestorerCardView(restorerViewModel: RestorerViewModel(Restorer(
                name: "Mercy",
                description: "Heroes never die!",
                options: [.health, .armorPoints],
                pricePerHealthBundle: 10,
                pricePerArmorPointBundle: 10)))
        }
    }
}
