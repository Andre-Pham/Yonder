//
//  MapView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct MapView: View {
    @StateObject private var scaleStateManager = ScaleStateManager(scales: YonderCoreGraphics.mapScales)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                // Note:
                // This layout transitioned from a VStack to a (technically less efficient) overlay
                // For reasoning, see: https://github.com/Andre-Pham/Yonder/issues/3
                
                MapGridView(scaleStateManager: self.scaleStateManager)
                
                VStack(spacing: 0) {
                    MapHeaderView(
                        scaleStateManager: self.scaleStateManager,
                        pageGeometry: geo
                    )
                    
                    Spacer()
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
