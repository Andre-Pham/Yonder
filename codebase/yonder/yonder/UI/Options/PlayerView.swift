//
//  PlayerView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct PlayerView: View {
    var player = Player(maxHealth: 200, location: NoLocation())
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("You")
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
        .background(.red)
    }
}

struct PlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
