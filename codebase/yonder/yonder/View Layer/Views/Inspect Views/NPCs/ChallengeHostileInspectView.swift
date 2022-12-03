//
//  ChallengeHostileInspectView.swift
//  yonder
//
//  Created by Andre Pham on 14/5/2022.
//

import SwiftUI

struct ChallengeHostileInspectView: View {
    @ObservedObject var foeViewModel: FoeViewModel
    
    var body: some View {
        InspectNPCBody(
            name: self.foeViewModel.name,
            description: self.foeViewModel.description,
            locationType: LocationType.challengeHostile
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

struct ChallengeHostileInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ChallengeHostileInspectView(foeViewModel: PreviewObjects.foeViewModel)
        }
    }
}
