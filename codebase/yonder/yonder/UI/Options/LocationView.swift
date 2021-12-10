//
//  LocationView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct LocationView: View {
    let image: Image
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 180)
                    .clipped()
                
                HStack(alignment: .bottom) {
                    Text("LOCATION NAME")
                        .font(YonderFonts.main(size: 28))
                        .padding(.leading, YonderCoreGraphics.padding)
                    Spacer()
                    Text("(Hostile)")
                        .font(YonderFonts.main())
                        .padding(.trailing, YonderCoreGraphics.padding)
                        .padding(.bottom, 3)
                }
                
                .foregroundColor(.Yonder.textMaxContrast)
                .frame(width: geo.size.width, height: YonderCoreGraphics.padding*3)
                .padding(.bottom, YonderCoreGraphics.borderWidth)
                .background(Color.Yonder.backgroundMinDepth)
                .frame(width: geo.size.width, height: 180, alignment: .bottomLeading)
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(image: YonderImages.majorInnImage)
    }
}
