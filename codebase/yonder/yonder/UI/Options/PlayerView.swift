//
//  PlayerView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct PlayerView: View {
    var player = Player(maxHealth: 200, location: NoLocation())
    @State private var showingPlayerSheet = false
    
    var body: some View {
        Button {
            showingPlayerSheet.toggle()
        } label: {
            VStack(alignment: .leading, spacing: 3) {
                Text("You")
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
        .sheet(isPresented: $showingPlayerSheet) {
            Text("Wow!")
        }
    }
}

struct PlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
