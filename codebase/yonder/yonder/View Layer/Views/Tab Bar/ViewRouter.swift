//
//  ViewRouter.swift
//  yonder
//
//  Created by Andre Pham on 16/4/2022.
//

import Foundation

class ViewRouter: ObservableObject {
    
    enum Page {
        case primary
        case inventory
        case map
        case settings
    }
    
    @Published private(set) var currentPage: Page = .primary
    
    func switchPage(to page: Page) {
        self.currentPage = page
    }
    
}
