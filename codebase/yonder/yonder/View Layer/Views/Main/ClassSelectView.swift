//
//  ClassSelectView.swift
//  yonder
//
//  Created by Andre Pham on 8/12/2022.
//

import SwiftUI

struct ClassSelectView: View {
    @Binding var isShowing: Bool
    let onSelection: (_ selection: PlayerClassOption) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            VStack {
                YonderText(text: Strings("classMenu.title").local, size: .title2, multilineTextAlignment: .center)
                    .padding(.bottom, 80)
                
                ForEach(PlayerClassOption.availableOptions, id: \.self) { option in
                    YonderButton(text: option.name) {
                        self.onSelection(option)
                    }
                    .padding(.bottom)
                }
                
                YonderButton(text: Strings("button.cancel").local) {
                    self.onCancel()
                }
                .padding(.top, 64)
            }
        }
    }
}

struct ClassSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ClassSelectView(isShowing: .constant(true)) { selection in
            // Use select class here
        } onCancel: {
            // Cancel code here
        }
    }
}
