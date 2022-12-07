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
        HostileInspectView(
            foeViewModel: self.foeViewModel,
            locationType: LocationType.boss
        )
    }
}

struct BossInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            BossInspectView(foeViewModel: PreviewObjects.foeViewModel)
        }
    }
}
