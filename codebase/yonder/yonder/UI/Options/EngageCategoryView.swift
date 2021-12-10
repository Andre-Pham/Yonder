//
//  EngageCategoryView.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import SwiftUI

struct EngageCategoryView: View, Identifiable {
    let title: String
    let id = UUID()
    
    var body: some View {
        ZStack {
            Color.Yonder.backgroundMinDepth
            VStack {
                Text(title)
                    .foregroundColor(.Yonder.textMaxContrast)
                    .font(YonderFonts.main(size: 24))
            }
        }
    }
}

struct EngageCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        EngageCategoryView(title: "Weapons")
    }
}
