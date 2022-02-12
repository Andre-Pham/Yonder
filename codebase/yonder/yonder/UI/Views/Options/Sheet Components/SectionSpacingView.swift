//
//  SectionSpacingView.swift
//  yonder
//
//  Created by Andre Pham on 13/2/2022.
//

import Foundation
import SwiftUI

struct SectionSpacingView: View {
    var body: some View {
        Rectangle()
            .frame(height: YonderCoreGraphics.paragraphSpacing*2)
    }
}
