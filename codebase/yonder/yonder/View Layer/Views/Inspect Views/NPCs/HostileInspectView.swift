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
            YonderText(text: Strings("inspect.title.stats").local, size: .inspectSheetTitle)
            
            InspectStatsBody {
                InspectStatView(
                    title: Strings("stat.health").local,
                    value: self.foeViewModel.health,
                    maxValue: self.foeViewModel.maxHealth,
                    image: YonderIcons.healthIcon)
                
                InspectStatView(
                    title: Strings("stat.damage").local,
                    value: self.foeViewModel.weaponViewModel.damage,
                    indicativeValue: self.foeViewModel.getIndicativeDamage(),
                    image: YonderIcons.foeDamageIcon)
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
