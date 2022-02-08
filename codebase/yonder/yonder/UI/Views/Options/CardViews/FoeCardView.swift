//
//  FoeCardView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct FoeCardView: View {
    @ObservedObject var foeViewModel: FoeViewModel
    
    var body: some View {
        CardBody(name: foeViewModel.name) {
            CardRowView(value: "\(self.foeViewModel.weaponViewModel.damage)", image: YonderImages.foeDamageIcon)
            
            CardRowView(value: "\(self.foeViewModel.health)", maxValue: "\(self.foeViewModel.maxHealth)", image: YonderImages.healthIcon)
        }
    }
}

struct EnemyCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
            FoeCardView(foeViewModel: FoeViewModel(FoeAbstract(maxHealth: 500, weapon: BasicWeapon(damage: 5, durability: 5, basePurchasePrice: 5))))
        }
    }
}
