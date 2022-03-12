//
//  InteractorViewModel.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import Combine

class InteractorViewModel: ObservableObject {
    
    // interactor can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var interactor: InteractorAbstract
    var subscriptions: Set<AnyCancellable> = [] // Public so children can access
    
    private(set) var name: String
    private(set) var description: String
    
    init(_ interactor: InteractorAbstract) {
        self.interactor = interactor
        
        // Set properties to match Interactor
        
        self.name = self.interactor.name
        self.description = self.interactor.description
    }
    
}

