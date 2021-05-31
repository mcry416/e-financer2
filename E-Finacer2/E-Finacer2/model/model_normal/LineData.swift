//
//  LineData.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/21.
//

import Foundation
class LineData: NSObject {
    var x: String!
    var y: String!
    
    override init() {
        super.init()
    }
    
    init(x: String, y: String) {
        self.x = x
        self.y = y
    }
}
