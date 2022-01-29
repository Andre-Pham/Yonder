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
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                MapHeaderView(scaleStateManager: self.scaleStateManager)
                
                MapGridView(scaleStateManager: self.scaleStateManager)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
