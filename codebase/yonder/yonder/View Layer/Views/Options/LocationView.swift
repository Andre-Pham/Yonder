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
                    YonderIconTextPair(image: self.locationViewModel.getTypeImage(), text: self.locationViewModel.name, size: .cardBody)
                    
                    Spacer()
                }
                .padding(YonderCoreGraphics.padding)
                .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2)
                .background(YonderColors.backgroundMaxDepth)
                .frame(width: geo.size.width - YonderCoreGraphics.borderWidth*2, height: self.cardHeight - YonderCoreGraphics.borderWidth*2, alignment: .bottomLeading)
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
            
            LocationView(locationViewModel: PreviewObjects.locationViewModel())
        }
    }
}
