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
            YonderText(text: Strings.Inspect.Title.Stats.local, size: .inspectSheetTitle)
            
            InspectStatsBody {
                InspectStatView(
                    title: Strings.Inspect.Stat.Health.local,
                    value: self.foeViewModel.health,
                    maxValue: self.foeViewModel.maxHealth,
                    image: YonderImages.healthIcon)
                
                InspectStatView(
                    title: Strings.Inspect.Stat.Damage.local,
                    value: self.foeViewModel.weaponViewModel.damage,
                    image: YonderImages.foeDamageIcon)
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
