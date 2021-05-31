//
//  BrowserLoanitem.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/21.
//

import Foundation
class BrowserLoanItem: NSObject {
    public var shouldRepayment: String!
    public var loanTime: String!
    public var isEnd: String!
    
    override init() {
        super.init()
    }
    
    init(shouldRepayment: String, loanTime: String, isEnd: String) {
        self.shouldRepayment = shouldRepayment
        self.loanTime = loanTime
        self.isEnd = isEnd
    }
}
