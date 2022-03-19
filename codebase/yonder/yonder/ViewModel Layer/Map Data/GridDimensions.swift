//
//  GridDimensions.swift
//  yonder
//
//  Created by Andre Pham on 16/1/2022.
//

import Foundation
import SwiftUI

// There is a lot of questionable maths in this... but it works, so just treat it like a blackbox with columns, spacing and height as parameters
class GridDimensions: ObservableObject {
    
    let columnsCount: Int
    let spacing: CGFloat
    let hexagonFrameHeight: CGFloat
    
    let maxLocationHeight: Int = 100 // TEMP
    let hexagonCount: Int
    let hexagonFrameWidth: CGFloat
    let hexagonWidth: CGFloat
    let distanceBetweenColumnCentres: CGFloat
    
    init(columnsCount: Int = 6, spacing: CGFloat = 0, hexagonFrameHeight: CGFloat = 240) {
        self.columnsCount = columnsCount
        self.spacing = spacing
        self.hexagonFrameHeight = hexagonFrameHeight
        
        self.hexagonCount = self.maxLocationHeight*self.columnsCount
        self.hexagonFrameWidth = MathConstants.hexagonWidthToHeight*(self.hexagonFrameHeight + 2*self.spacing/tan((120.0 - 90.0)*MathConstants.degreesToRadians)) // I don't remember how I got this so just accept it's magic
        self.hexagonWidth = self.hexagonFrameWidth/2 * cos(.pi/6) * 2
        self.distanceBetweenColumnCentres = self.hexagonWidth/2 + self.spacing/2
    }
    
    func getHorizontalOffset(hexagonIndex: Int) -> CGFloat {
        return self.distanceBetweenColumnCentres/2 * (self.isEvenRow(hexagonIndex) ? -1 : 1)
    }
    
    func isEvenRow(_ index: Int) -> Bool {
        return index/self.columnsCount % 2 == 0
    }
    
    func getGridHexagonFrameWidth() -> CGFloat {
        return self.hexagonFrameHeight*MathConstants.hexagonWidthToHeight/2 + self.spacing
    }
    
    func getGridHexagonFrameHeight() -> CGFloat {
        // 0.216 was found from trial and error so don't think too hard about it
        return self.hexagonFrameHeight*0.216
    }
    
}
