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
//    let cardHeight: CGFloat = 250
    // Placeholder until assigned on appear
    @State private var viewHeight = 250.0
    
    init(locationViewModel: LocationViewModel, optionsStateManager: OptionsStateManager) {
        self.locationViewModel = locationViewModel
        // Maintain as @StateObject to not re-create every view redraw
        self._animationQueue = StateObject(wrappedValue: NPCAnimation(optionsStateManager: optionsStateManager))
    }
    
    var body: some View {
        GeometryReader { geo in
            let cardHeight = geo.size.width/1.624
            ZStack(alignment: .bottom) {
                YonderImages.forestBackgroundImage.image
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2, height: cardHeight - YonderCoreGraphics.borderWidth*2)
                    .clipped()
                    .offset(x: YonderCoreGraphics.borderWidth, y: YonderCoreGraphics.borderWidth)
                    .overlay(alignment: .bottom) {
                        self.animationQueue.frame
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                        // The frame is relative to a size of 80.0 because that's the size of image I originally used to position everything - then we scale different frame sizes relative to their actual frame size
                            .frame(width: geo.size.width*self.animationQueue.frameSize.width/80.0, height: geo.size.width/2.538*self.animationQueue.frameSize.height/80.0)
                            .offset(x: YonderCoreGraphics.borderWidth, y: YonderCoreGraphics.borderWidth)
//                            .offset(y: geo.size.width/8.458)
                        // These offsets need to be relative to the geometry size because these change from device to device so aspect ratios need to be maintained for consistent viewing
                            .offset(y: geo.size.width/60.0)
                        // For some reason sprites tend to be right-leaning and centre better when adjusted
                            .offset(x: -geo.size.width/65.0)
//                            .border(.blue, width: 2)
                    }
                
                YonderImages.forestForegroundImage.image
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2, height: cardHeight - YonderCoreGraphics.borderWidth*2)
                    .clipped()
                    .offset(x: YonderCoreGraphics.borderWidth, y: YonderCoreGraphics.borderWidth)
                
                
//                HStack {
//                    YonderIconTextPair(image: self.locationViewModel.getTypeImage(), text: self.locationViewModel.name, size: .cardBody)
//
//                    Spacer()
//                }
//                .padding(YonderCoreGraphics.padding)
//                .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2)
//                .background(YonderColors.backgroundMaxDepth)
//                .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2, height: self.cardHeight - YonderCoreGraphics.borderWidth*2, alignment: .bottomLeading)
                
                // TODO: Scale the animation to be proportional to the frame size of the animation sequence
                // TODO: Also figure out how to make these bigger in general, without shifting the entire layout of this view
//                self.animationQueue.frame
//                    .resizable()
//                    .interpolation(.none)
//                    .scaledToFit()
//                    .frame(width: geo.size.width, height: self.cardHeight)
            }
            .onAppear {
                self.viewHeight = cardHeight
            }
        }
        .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
        .frame(maxWidth: .infinity)
        .frame(height: self.viewHeight)
        .padding(.horizontal, YonderCoreGraphics.padding)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            LocationView(
                locationViewModel: PreviewObjects.locationViewModel,
                optionsStateManager: OptionsStateManager(playerViewModel: PreviewObjects.playerViewModel)
            )
        }
    }
}
