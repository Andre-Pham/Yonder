//
//  WowView.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2022.
//

import Foundation
import SwiftUI

struct WowView: View {
    // Parameters
    let down: Int
    let downAcross: Int
    let spacing: CGFloat
    let offset: CGFloat
    
    var body: some View {
        /*ForEach(0..<5) { test in
            ForEach(0..<1) { test2 in
                GeometryReader { wow in
                    Text("\(wowParam)")
                }
            }
        }*/
        GeometryReader { geo in
            GridConnection(down: down, downAcross: downAcross, geoWidth: geo.size.width, geoHeight: geo.size.height, spacing: spacing, horizontalOffset: offset)
        }
    }
}
