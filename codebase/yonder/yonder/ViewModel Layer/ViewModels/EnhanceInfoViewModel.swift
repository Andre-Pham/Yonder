//
//  EnhanceInfoViewModel.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

class EnhanceInfoViewModel: ObservableObject {
    
    private(set) var enhanceInfo: EnhanceInfo
    public let name: String
    public let id: UUID
    
    init(_ enhanceInfo: EnhanceInfo) {
        self.enhanceInfo = enhanceInfo
        self.name = enhanceInfo.name
        self.id = enhanceInfo.id
    }
    
}
