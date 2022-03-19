//
//  ScaleStateManager.swift
//  yonder
//
//  Created by Andre Pham on 6/1/2022.
//

import Foundation
import SwiftUI

class ScaleStateManager: ObservableObject {
    
    private let scales: [CGFloat]
    var scalesCount: Int {
        return self.scales.count
    }
    @Published private(set) var scaleIndex: Int = 2
    var scale: CGFloat {
        return self.scales[self.scaleIndex]
    }
    var scaleIsMin: Bool {
        return self.scaleIndex == 0
    }
    var scaleIsMax: Bool {
        return self.scaleIndex == self.scalesCount-1
    }
    @Published private(set) var scrollViewSize = CGSize()
    var scrollViewSizeScaledWidth: CGFloat {
        return self.scrollViewSize.width*self.scale
    }
    var scrollViewSizeScaledHeight: CGFloat {
        return self.scrollViewSize.height*self.scale
    }
    
    init(scales: [CGFloat]) {
        self.scales = scales
    }
    
    func adjustScaleIndex(by amount: Int) {
        if amount < 0 {
            self.scaleIndex = max(self.scaleIndex + amount, 0)
        }
        else if amount > 0 {
            self.scaleIndex = min(self.scaleIndex + amount, self.scalesCount-1)
        }
    }
    
    func setScrollViewSize(to size: CGSize) {
        self.scrollViewSize = size
    }
    
}
