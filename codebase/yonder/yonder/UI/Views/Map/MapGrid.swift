//
//  MapGrid.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

// There is a lot of questionable maths in this... but it works, so just treat it like a blackbox with columns, spacing and height as parameters
struct MapGrid: View {
    // Parameters
    let columnsCount: Int = 6
    let spacing: CGFloat = 10.0
    let hexagonFrameHeight: CGFloat = 150
    
    var maxLocationHeight: Int = 20 // TEMP
    var hexagonFrameWidth: CGFloat {
        // I don't remember how I got this so just accept it's magic
        return (hexagonFrameHeight + 2*spacing/tan((120.0 - 90.0)*MathConstants.degreesToRadians))*MathConstants.hexagonWidthToHeight
    }
    var hexagonWidth: CGFloat {
        return hexagonFrameWidth/2 * cos(.pi/6) * 2
    }
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(hexagonWidth), spacing: spacing), count: columnsCount)
        
        ScrollView([.vertical, .horizontal]) {
            LazyVGrid(columns: gridItems, spacing: spacing) {
                ForEach(0..<maxLocationHeight*columnsCount, id: \.self) { index in
                    ZStack {
                        Hexagon()
                            .fill(.black)
                            .onTapGesture {
                                print(index)
                            }
                            .overlay(Text("\(index)").foregroundColor(.white))
                            .frame(width: hexagonFrameWidth, height: hexagonFrameHeight/2)
                            .offset(x: isEvenRow(index) ? -(hexagonWidth/4 + spacing/4) : hexagonWidth/4 + spacing/4)
                            .frame(width: (hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + spacing, height: hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
                            .reverseScroll()
                        
                        if (Int.random(in: 0...3) == 0) {
                            Hexagon()
                                .fill(.blue)
                                .frame(width: hexagonFrameWidth/2, height: hexagonFrameHeight/4)
                                .offset(x: isEvenRow(index) ? -(hexagonWidth/4 + spacing/4) : hexagonWidth/4 + spacing/4)
                                .frame(width: hexagonWidth/2, height: hexagonFrameHeight*0.25/2)
                                .reverseScroll()
                        }
                        
                        GeometryReader { geo in
                            if (Int.random(in: 0...3) == 0) {
                                GridConnection(down: 1, downAcross: 2, geoWidth: geo.size.width, geoHeight: geo.size.height, spacing: spacing, offset: (hexagonWidth/4 + spacing/4)*(isEvenRow(index) ? -1 : 1))
                            }
                        }
                    }
                }
            }
            .frame(width: (hexagonWidth + spacing)*CGFloat(columnsCount) + spacing*6)
        }
        .padding(1) // Stops jittering
        .reverseScroll()
    }
    
    func isEvenRow(_ index: Int) -> Bool {
        return index/columnsCount % 2 == 0
    }
    
}

