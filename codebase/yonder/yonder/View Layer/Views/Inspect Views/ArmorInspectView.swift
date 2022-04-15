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
            
            InspectStatsBody {
                InspectStatView(title: Term.armorPoints.capitalized, value: self.armorViewModel.armorPoints, image: YonderImages.armorPointsIcon)
            }
            
            if let effectsDescription = self.armorViewModel.effectsDescription {
                YonderText(text: effectsDescription, size: .inspectSheetBody)
            }
            
            InspectSectionSpacingView()
            
            YonderText(text: armorViewModel.description, size: .inspectSheetBody)
        }
    }
}

struct ArmorInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .topLeading) {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            ArmorInspectView(armorViewModel: ArmorViewModel(ResistanceArmor(name: "Cool Resistance Armor", description: "Very Shiny.", type: .body, armorPoints: 500, damageFraction: 0.8, basePurchasePrice: 200)))
                .padding()
        }
    }
}