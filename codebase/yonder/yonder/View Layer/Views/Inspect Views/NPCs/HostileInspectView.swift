//
//  HostileInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct HostileInspectView: View {
    @ObservedObject var foeViewModel: FoeViewModel
    var locationType: LocationType = .hostile
    
    var body: some View {
        InspectBody {
            YonderText(text: self.foeViewModel.name, size: .inspectSheetTitle)
            
            InspectNPCTypeView()
            
            if let typeName = foeViewModel.typeName, let typeImage = foeViewModel.typeImage {
                YonderIconTextPair(
                    image: typeImage,
                    text: typeName,
                    size: .inspectSheetBody,
                    iconSize: .inspectSheet)
            }
            
            if !self.foeViewModel.description.isEmpty {
                YonderText(text: self.foeViewModel.description, size: .inspectSheetBody)
            }
            
            InspectSectionSpacingView()
            
            YonderText(text: Strings("inspect.title.stats").local, size: .inspectSheetTitle)
            
            InspectStatsBody {
                InspectStatView(
                    title: Strings("stat.health").local,
                    value: self.foeViewModel.health,
                    maxValue: self.foeViewModel.maxHealth,
                    image: YonderIcons.healthIcon)
                
                if self.foeViewModel.damageStatIsVisible {
                    InspectStatView(
                        title: Strings("stat.damage").local,
                        value: self.foeViewModel.weaponViewModel.damage,
                        indicativeValue: self.foeViewModel.getIndicativeDamage(),
                        image: YonderIcons.foeDamageIcon
                    )
                }
                
                if let goldSteal = self.foeViewModel.goldSteal, self.foeViewModel.goldStealStatIsVisible {
                    InspectStatView(
                        title: Strings("stat.goldSteal").local,
                        value: goldSteal,
                        image: YonderIcons.goblinGoldStealIcon
                    )
                }
            }
            
            InspectFoeStatus(foeViewModel: self.foeViewModel)
            
            InspectSectionSpacingView()
            
            Group {
                YonderText(text: Strings("inspect.title.info").local, size: .inspectSheetTitle)
                
                if let typeDescription = self.foeViewModel.typeDescription {
                    YonderText(text: typeDescription, size: .inspectSheetBody)
                }
                
                if let bossDescription = self.foeViewModel.bossDescription {
                    YonderText(text: bossDescription, size: .inspectSheetBody)
                }
                
                YonderText(text: self.locationType.description, size: .inspectSheetBody)
            }
        }
    }
}

struct HostileInspectView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            HostileInspectView(foeViewModel: PreviewObjects.foeViewModel)
        }
        
        PreviewContentView {
            HostileInspectView(foeViewModel: PreviewObjects.goblinViewModel)
        }
    }
}
