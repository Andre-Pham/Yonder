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
    // Assigned on onAppear
    @State private var viewHeight = 0.0
    // Magic number for scaling down size, smaller number -> larger image
    private let sizeDial = 178.0
    private let background: YonderImage
    private let foreground: YonderImage
    
    init(locationViewModel: LocationViewModel, optionsStateManager: OptionsStateManager) {
        self.locationViewModel = locationViewModel
        // Maintain as @StateObject to not re-create every view redraw
        self._animationQueue = StateObject(wrappedValue: NPCAnimation(optionsStateManager: optionsStateManager))
        self.background = locationViewModel.background
        self.foreground = locationViewModel.foreground
    }
    
    var body: some View {
        
        YonderBorder1 {
        
            
//                let viewWidth = geo.size.width
//                let cardWidth = viewWidth
//                let cardHeight = cardWidth/(self.background.width/self.background.height)
//                let viewHeight = cardHeight
                ZStack(alignment: .bottom) {
                    self.background.image
                        .resizable()
                        .interpolation(.none)
//                        .scaledToFill()
                        .overlay {
                            if let name = self.locationViewModel.getNPCName() {
                                VStack {
                                    YonderText(text: name, size: .cardSubscript)
                                        .padding(.horizontal, 9)
                                        .padding(.vertical, 4)
                                        .background(.black.opacity(0.5))
                                        .padding()
                                    
                                    Spacer()
                                }
                                
                            }
                        }
                        .overlay(alignment: .bottom) {
                            self.animationQueue.frame
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
//                                .frame(
//                                    width: self.background.width*self.animationQueue.frameSize.width/self.sizeDial,
//                                    height: self.background.height*self.animationQueue.frameSize.height/self.sizeDial
//                                )
                            // These offsets need to be relative to the geometry size because these change from device to device so aspect ratios need to be maintained for consistent viewing
                                .offset(y: self.background.width/35.0) // Magic
                            // Sprites tend to be slightly right-leaning and centre better when adjusted
                                .offset(x: -self.background.width/80.0) // Magic
                        }
                    // Set frame after overlay - any animations that extend outside the card's frame are clipped
//                        .frame(width: .infinity)
//                        .aspectRatio(contentMode: .fit)
//                        .clipped()
                        
                        .aspectRatio(self.background.width/self.background.height, contentMode: .fit)
//                        .frame(maxWidth: .infinity)
                    
                    self.foreground.image
                        .resizable()
                        .interpolation(.none)
                        .aspectRatio(self.background.width/self.background.height, contentMode: .fit)
//                        .scaledToFill()
//                        .frame(width: .infinity)
//                        .clipped()
                }
            
                
                
//            }
              
//            .frame(maxWidth: .infinity)
//            .frame(height: self.viewHeight == 0 ? 50 : self.viewHeight)
        
        }
        .padding(.horizontal, YonderCoreGraphics.padding)
   
        
        
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
