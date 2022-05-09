//
//  FoeInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct FoeInspectView: View {
    @ObservedObject var foeViewModel: FoeViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: self.foeViewModel.name, size: .inspectSheetTitle)
            
            InspectNPCTypeView()
            
            YonderText(text: self.foeViewModel.description, size: .inspectSheetBody)
            
            InspectSectionSpacingView()
            
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
            
            InspectSectionSpacingView()
            
            YonderText(text: "Info", size: .inspectSheetTitle)
            
            YonderText(text: LocationType.hostile.npcDescription, size: .inspectSheetBody)
        }
    }
}

struct FoeInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            FoeInspectView(foeViewModel: FoeViewModel(Foe(maxHealth: 500, weapon: Weapon(basePill: DamageBasePill(damage: 50, durability: 5), durabilityPill: DecrementDurabilityPill()))))
        }
    }
}
