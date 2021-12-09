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
            HStack {
                Text("450")
                Spacer()
                Text("/500")
            }
            HStack {
                Text("100")
                Spacer()
                Text("/100")
            }
            Spacer()
        }
        .background(.blue)
    }
}

struct EnemyComponent_Previews: PreviewProvider {
    static var previews: some View {
        EnemyView()
    }
}
