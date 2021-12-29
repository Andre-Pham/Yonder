//
//  OptionView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionView: View {
    let title: String
    
    var body: some View {
        ZStack {
            Color.Yonder.backgroundMinDepth
            VStack {
                Text(title)
                    .foregroundColor(.Yonder.textMaxContrast)
                    .font(YonderFonts.main(size: 24))
                // Icon would go underneith
            }
        }
    }
}

struct EngageOptionView: View {
    var body: some View {
        OptionView(title: "Engage")
    }
}

struct OptionViews_Previews: PreviewProvider {
    static var previews: some View {
        EngageOptionView()
    }
}
