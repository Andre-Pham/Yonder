//
//  LocationView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    let cardHeight: CGFloat = 200
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                self.locationViewModel.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: self.cardHeight)
                    .clipped()
                
                HStack {
                    LocationIconView(locationType: self.locationViewModel.type)
                    
                    YonderText(text: self.locationViewModel.name, size: .cardBody)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundColor(.Yonder.textMaxContrast)
                .padding(.bottom, YonderCoreGraphics.borderWidth)
                .frame(width: geo.size.width, height: 50)
                .background(Color.Yonder.backgroundMaxDepth)
                .frame(width: geo.size.width, height: self.cardHeight, alignment: .bottomLeading)
            }
        }
        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        .frame(maxWidth: .infinity)
        .frame(height: self.cardHeight)
        .padding(.horizontal, YonderCoreGraphics.padding)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(locationViewModel: LocationViewModel(HostileLocation(foe: FoeAbstract(maxHealth: 50, weapon: BaseAttack(damage: 50)))))
    }
}
