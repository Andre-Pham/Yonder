//
//  LocationView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                locationViewModel.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 180)
                    .clipped()
                
                HStack(alignment: .bottom) {
                    Text(locationViewModel.name)
                        .font(YonderFonts.main(size: 28))
                        .padding(.leading, YonderCoreGraphics.padding)
                    
                    Spacer()
                    
                    Text(locationViewModel.type)
                        .font(YonderFonts.main())
                        .padding(.trailing, YonderCoreGraphics.padding)
                        .padding(.bottom, 3)
                }
                .foregroundColor(.Yonder.textMaxContrast)
                .frame(width: geo.size.width, height: YonderCoreGraphics.padding*3)
                .padding(.bottom, YonderCoreGraphics.borderWidth)
                .background(Color.Yonder.backgroundMaxDepth)
                .frame(width: geo.size.width, height: 180, alignment: .bottomLeading)
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(locationViewModel: LocationViewModel(NoLocation(), player: Player(maxHealth: 200, location: NoLocation())))
    }
}
