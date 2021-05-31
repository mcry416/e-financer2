//
//  Normal.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation

class User: NSObject {
    var phone: String!
    var password: String!
    
    override init() {
        super.init()
    }
    
    init(phone: String, password: String) {
        self.phone = phone
        self.password = password
    }
}
