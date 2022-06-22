//
//  HostileInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct HostileInspectView: View {
    @ObservedObject var foeViewModel: FoeViewModel
    
    var body: some View {
        InspectNPCBody(
            name: self.foeViewModel.name,
            description: self.foeViewModel.description,
            locationType: LocationType.hostile
        ) {
            YonderText(text: Strings.Inspect.Title.Stats.local, size: .inspectSheetTitle)
            
            InspectStatsBody {
                InspectStatView(
                    title: Strings.Stat.Health.local,
                    value: self.foeViewModel.health,
                    maxValue: self.foeViewModel.maxHealth,
                    image: YonderImages.healthIcon)
                
                InspectStatView(
                    title: Strings.Stat.Damage.local,
                    value: self.foeViewModel.weaponViewModel.damage,
                    image: YonderImages.foeDamageIcon)
            }
        }
    }
}

struct FoeInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            HostileInspectView(foeViewModel: PreviewObjects.foeViewModel)
        }
    }
}
