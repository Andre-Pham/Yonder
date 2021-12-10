//
//  EnemyView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct EnemyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enemy")
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            
            HStack {
                Text("450")
                Spacer()
                Text("/500")
            }
            .padding(.leading)
            .padding(.trailing)
            
            HStack {
                Text("100")
                Spacer()
                Text("/100")
            }
            .padding(.leading)
            .padding(.trailing)
            
            Spacer()
        }
        .foregroundColor(.Yonder.textMidContrast)
        .background(Color.Yonder.backgroundMinDepth)
    }
}

struct EnemyComponent_Previews: PreviewProvider {
    static var previews: some View {
        EnemyView()
    }
}
