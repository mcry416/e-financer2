//
//  StoreUserService.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation
protocol StoreUserService{
    func getUser() -> Array<User>
    func setUser(phone: String, password: String)
}
