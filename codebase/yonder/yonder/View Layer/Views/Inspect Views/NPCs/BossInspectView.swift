//
//  BossInspectView.swift
//  yonder
//
//  Created by Andre Pham on 14/5/2022.
//

import SwiftUI

struct BossInspectView: View {
    @ObservedObject var foeViewModel: FoeViewModel
    
    var body: some View {
        InspectNPCBody(
            name: self.foeViewModel.name,
            description: self.foeViewModel.description,
            locationType: LocationType.boss
        ) {
            YonderText(text: Term.stats.capitalized, size: .inspectSheetTitle)
            
            InspectStatsBody {
                InspectStatView(
                    title: Term.health.capitalized,
                    value: self.foeViewModel.health,
                    maxValue: self.foeViewModel.maxHealth,
                    image: YonderImages.healthIcon)
                
                InspectStatView(
                    title: Term.damage.capitalized,
                    value: self.foeViewModel.weaponViewModel.damage,
                    image: YonderImages.foeDamageIcon)
            }
        }
    }
}

struct BossInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            BossInspectView(foeViewModel: FoeViewModel(Foe(maxHealth: 500, weapon: Weapon(basePill: DamageBasePill(damage: 50, durability: 5), durabilityPill: DecrementDurabilityPill()))))
        }
    }
}
