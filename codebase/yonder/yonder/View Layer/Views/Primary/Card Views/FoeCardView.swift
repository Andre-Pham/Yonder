//
//  FoeCardView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct FoeCardView: View {
    @ObservedObject var foeViewModel: FoeViewModel
    @State private var showDamageStat: Bool
    @State private var showGoldStealStat: Bool
    private let statTransition: AnyTransition = .move(edge: .trailing).combined(with: .opacity)
    
    init(foeViewModel: FoeViewModel) {
        self.foeViewModel = foeViewModel
        self.showDamageStat = foeViewModel.damageStatIsVisible
        self.showGoldStealStat = foeViewModel.goldStealStatIsVisible
    }
    
    var body: some View {
        CardBody {
            CardNPCTypeView()
            
            if let typeName = self.foeViewModel.typeName, let typeImage = self.foeViewModel.typeImage {
                YonderIconTextPair(
                    image: typeImage,
                    text: typeName,
                    size: .cardSubscript,
                    iconSize: .cardSubscript
                )
            }
            
            if self.showDamageStat {
                CardRowView(
                    value: self.foeViewModel.weaponViewModel.damage,
                    indicativeValue: self.foeViewModel.getIndicativeDamage(),
                    image: YonderIcons.foeDamageIcon
                )
                .transition(self.statTransition)
            }
            
            if let goldSteal = self.foeViewModel.goldSteal, self.showGoldStealStat {
                CardRowView(
                    value: goldSteal,
                    image: YonderIcons.goblinGoldStealIcon
                )
                .transition(self.statTransition)
            }
            
            CardRowView(
                value: self.foeViewModel.health,
                maxValue: self.foeViewModel.maxHealth,
                image: YonderIcons.healthIcon
            )
            
            if let bossHint = self.foeViewModel.bossHint {
                Spacer()
                
                YonderText(text: bossHint, size: .cardSubscript)
            }
        }
        .onReceive(self.foeViewModel.weaponViewModel.$damage) { damage in
            withAnimation {
                self.showDamageStat = self.foeViewModel.damageStatIsVisible
            }
        }
        .onReceive(self.foeViewModel.$goldSteal) { goldSteal in
            withAnimation {
                self.showGoldStealStat = self.foeViewModel.goldStealStatIsVisible
            }
        }
    }
}

struct EnemyCardView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            FoeCardView(foeViewModel: PreviewObjects.foeViewModel)
        }
        
        PreviewContentView {
            FoeCardView(foeViewModel: PreviewObjects.goblinViewModel)
        }
        
        PreviewContentView {
            FoeCardView(foeViewModel: PreviewObjects.bruteViewModel)
        }
    }
}
