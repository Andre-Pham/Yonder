//
//  LocationView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @StateObject var npcAnimationQueue: NPCAnimation
    @StateObject var landmarkAnimationQueue: LandmarkAnimation
    private let platform: YonderImage
    // Adjust to preference
    private let viewHeight = 200.0
    // NPC sprites tend to be slightly right-leaning and centre better when adjusted
    private var npcXOffset: Double = -4.0
    private var npcYOffset: Double {
        return -1.5*self.npcAnimationQueue.frameSize.height + 130.0 + 50*(self.viewHeight - 200.0)/100.0
    }
    private var landmarkXOffset: Double = 0.0
    private var landmarkYOffset: Double {
        return -1.5*self.landmarkAnimationQueue.frameSize.height + 168.0 + 50*(self.viewHeight - 200.0)/100.0
    }
    
    // Note to future self:
    // If I ever wish to check if the animation is empty
    // I created a property on the animation queue:
    // self.npcAnimationQueue.emptyAnimation
    
    init(locationViewModel: LocationViewModel, optionsStateManager: OptionsStateManager) {
        self.locationViewModel = locationViewModel
        // Maintain as @StateObject to not re-create every view redraw
        self._npcAnimationQueue = StateObject(wrappedValue: NPCAnimation(optionsStateManager: optionsStateManager))
        self._landmarkAnimationQueue = StateObject(wrappedValue: LandmarkAnimation())
        self.platform = locationViewModel.platformImage
    }
    
    var body: some View {
        Color.clear
            .frame(height: self.viewHeight)
            .overlay {
                VStack(spacing: 0) {
                    Spacer()
                    
                    self.platform.image
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .offset(y: 11)
                        .frame(width: 305)
                }
            }
            // Overlay because the animation frame is actually larger than the view frame
            // If we want to position it relative to it, we need to overlay (or use a ZStack)
            .overlay {
                switch self.locationViewModel.type {
                case .none, .bridge:
                    self.landmarkAnimationQueue.frame
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(
                            width: 3.0*self.landmarkAnimationQueue.frameSize.width,
                            height: 3.0*self.landmarkAnimationQueue.frameSize.height
                        )
                        .offset(x: self.landmarkXOffset, y: self.landmarkYOffset)
                default:
                    self.npcAnimationQueue.frame
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(
                            width: 3.0*self.npcAnimationQueue.frameSize.width,
                            height: 3.0*self.npcAnimationQueue.frameSize.height
                        )
                        .offset(x: self.npcXOffset, y: self.npcYOffset)
                }
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
