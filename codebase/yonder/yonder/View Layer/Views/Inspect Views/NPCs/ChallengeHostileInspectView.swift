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
        HostileInspectView(
            foeViewModel: self.foeViewModel,
            locationType: LocationType.challengeHostile
        )
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
