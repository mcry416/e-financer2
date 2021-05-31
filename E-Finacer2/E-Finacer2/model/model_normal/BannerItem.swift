//
//  BannerItem.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/21.
//

import Foundation
class BannerItem: NSObject {
    var x: String!
    
    override init() {
        super.init()
    }
    
    init(x: String, y: String) {
        self.x = x
    }
}
