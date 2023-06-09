//
//  LocationView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @StateObject var animationQueue: NPCAnimation
    let cardHeight: CGFloat = 200
    
    init(locationViewModel: LocationViewModel, optionsStateManager: OptionsStateManager) {
        self.locationViewModel = locationViewModel
        // Maintain as @StateObject to not re-create every view redraw
        self._animationQueue = StateObject(wrappedValue: NPCAnimation(optionsStateManager: optionsStateManager)!)
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                self.locationViewModel.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: self.cardHeight)
                    .clipped()
                
                
                HStack {
                    YonderIconTextPair(image: self.locationViewModel.getTypeImage(), text: self.locationViewModel.name, size: .cardBody)
                    
                    Spacer()
                }
                .padding(YonderCoreGraphics.padding)
                .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2)
                .background(YonderColors.backgroundMaxDepth)
                .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2, height: self.cardHeight - YonderCoreGraphics.borderWidth*2, alignment: .bottomLeading)
                
                self.animationQueue.frame
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: geo.size.width, height: self.cardHeight)
            }
        }
        .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
        .frame(maxWidth: .infinity)
        .frame(height: self.cardHeight)
        .padding(.horizontal, YonderCoreGraphics.padding)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            LocationView(
                locationViewModel: PreviewObjects.locationViewModel,
                optionsStateManager: OptionsStateManager(playerViewModel: PreviewObjects.playerViewModel)
            )
        }
    }
}
