//
//  EnemyView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct EnemyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Corn Man")
                .font(YonderFonts.main())
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            
            HStack {
                Text("450")
                    .font(YonderFonts.main(size: 26))
                
                Spacer()
                
                Text("/500")
                    .font(YonderFonts.main(size: 18))
            }
            .padding(.leading)
            .padding(.trailing)
            
            HStack {
                Text("100")
                    .font(YonderFonts.main(size: 26))
                
                Spacer()
                
                Text("/100")
                    .font(YonderFonts.main(size: 18))
            }
            .padding(.leading)
            .padding(.trailing)
            
            Spacer()
        }
        .foregroundColor(.Yonder.textMaxContrast)
        .background(Color.Yonder.backgroundMinDepth)
    }
}

struct EnemyComponent_Previews: PreviewProvider {
    static var previews: some View {
        EnemyView()
    }
}
