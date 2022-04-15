//
//  ViewRouter.swift
//  yonder
//
//  Created by Andre Pham on 16/4/2022.
//

import Foundation

class ViewRouter: ObservableObject {
    
    enum Page {
        case options
        case inventory
        case map
        case settings
    }
    
    @Published private(set) var currentPage: Page = .options
    
    func switchPage(to page: Page) {
        self.currentPage = page
    }
    
}
