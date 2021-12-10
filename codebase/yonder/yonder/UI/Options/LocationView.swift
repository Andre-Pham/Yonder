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
                    Text("Testing")
                        .padding(.leading, YonderCoreGraphics.padding)
                    Spacer()
                    Text("Testing again")
                        .padding(.trailing, YonderCoreGraphics.padding)
                }
                .foregroundColor(.Yonder.textMaxContrast)
                .frame(width: geo.size.width, height: YonderCoreGraphics.padding*3)
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
