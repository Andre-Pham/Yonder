//
//  PlayerCardAndSheetView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import SwiftUI

struct PlayerCardAndSheetView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var optionsSheetsStateManager: OptionsSheetsStateManager
    
    var body: some View {
        Button {
            self.optionsSheetsStateManager.playerSheetBinding = true
        } label: {
            PlayerCardView(playerViewModel: self.playerViewModel)
        }
        /*.sheet(isPresented: self.$optionsSheetsStateManager.playerSheetBinding) {
            Text("Wow!")
        }*/
    }
}

struct PlayerCardAndSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardAndSheetView(playerViewModel: PlayerViewModel(Player(maxHealth: 500, location: NoLocation())), optionsSheetsStateManager: OptionsSheetsStateManager())
    }
}
