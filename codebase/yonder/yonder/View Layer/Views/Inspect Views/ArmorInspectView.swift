//
//  ArmorInspectView.swift
//  yonder
//
//  Created by Andre Pham on 2/4/2022.
//

import SwiftUI

struct ArmorInspectView: View {
    @ObservedObject var armorViewModel: ArmorViewModel
    
    var body: some View {
        InspectBody {
            YonderText(text: self.armorViewModel.name, size: .inspectSheetTitle)
            
            InspectTagView(tag: self.armorViewModel.inspectTag)
            
            InspectSectionSpacingView()
            
            InspectStatsBody {
                InspectStatView(
                    title: Strings("stat.shields").local,
                    value: self.armorViewModel.armorPoints,
                    image: YonderIcons.armorPointsIcon
                )
            }
            
            if let effectsDescription = self.armorViewModel.effectsDescription {
                YonderText(text: effectsDescription, size: .inspectSheetBody)
            }
        }
    }
}

struct ArmorInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .topLeading) {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ArmorInspectView(armorViewModel: PreviewObjects.armorViewModel)
                .padding()
        }
    }
}
