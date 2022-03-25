//
//  InspectViewBuildingBlocks.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2022.
//

import Foundation
import SwiftUI

struct InspectBody<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: YonderCoreGraphics.paragraphSpacing) {
            content()
        }
    }
}

struct InspectStatsBody<Content: View>: View {
    private let content: () -> Content
    
    init(@ViewBuilder builder: @escaping () -> Content) {
        self.content = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            content()
        }
    }
}

struct InspectStatView: View {
    let title: String
    var prefix: String? = nil
    let value: Int
    var maxValue: Int? = nil
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image, sideLength: .inspectSheet)
            }
            
            HStack(alignment: .lastTextBaseline) {
                YonderTextAndNumeral(format: [.text, .numeral], text: ["\(self.title): \(self.prefix == nil ? "" : self.prefix!)"], numbers: [self.value], size: .inspectSheetBody)
                
                if let maxValue = maxValue {
                    YonderTextAndNumeral(format: [.text, .numeral], text: ["/"], numbers: [maxValue], size: .inspectSheetBody)
                }
            }
        }
    }
}

struct InspectSectionSpacingView: View {
    var body: some View {
        Rectangle()
            .frame(height: 10)
    }
}
