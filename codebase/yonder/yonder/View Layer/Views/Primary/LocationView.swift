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
    // TODO: These (background/foreground) are currently unused, but likely will serve a purpose down the road
    private let background: YonderImage
    private let foreground: YonderImage
    // Adjust to preference
    private let viewHeight = 200.0
    // Sprites tend to be slightly right-leaning and centre better when adjusted
    private var xOffset: Double = -4.0
    private var yOffset: Double {
        return -1.5*self.animationQueue.frameSize.height + 130.0 + 50*(self.viewHeight - 200.0)/100.0
    }
    
    // Note to future self:
    // If I ever wish to check if the animation is empty
    // I created a property on the animation queue:
    // self.animationQueue.emptyAnimation
    
    init(locationViewModel: LocationViewModel, optionsStateManager: OptionsStateManager) {
        self.locationViewModel = locationViewModel
        // Maintain as @StateObject to not re-create every view redraw
        self._animationQueue = StateObject(wrappedValue: NPCAnimation(optionsStateManager: optionsStateManager))
        self.background = locationViewModel.background
        self.foreground = locationViewModel.foreground
    }
    
    var body: some View {
        Color.clear
            .frame(height: self.viewHeight)
            .overlay {
                VStack(spacing: 0) {
                    Spacer()
                    
                    YonderImages.npcShadowImage.image
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .offset(y: -2)
                        .frame(width: 200)
                }
            }
            // Overlay because the animation frame is actually larger than the view frame
            // If we want to position it relative to it, we need to overlay (or use a ZStack)
            .overlay {
                self.animationQueue.frame
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(height: 3.0*self.animationQueue.frameSize.height)
                    .offset(x: self.xOffset, y: self.yOffset)
            }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        let player = PreviewObjects.playerViewModel
        let location = PreviewObjects.locationViewModel
        
        return ZStack {
            Color.red
                .ignoresSafeArea()
            
            LocationView(
                locationViewModel: location,
                optionsStateManager: OptionsStateManager(playerViewModel: player)
            )
            .onAppear {
                player.travel(to: location)
            }
        }
    }
}
