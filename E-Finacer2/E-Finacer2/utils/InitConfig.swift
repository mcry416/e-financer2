//
//  InitConfig.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation

class InitConfig {
    
    public static func isEnterUser() -> Bool{
        let userDefaults = UserDefaults.standard
        if userDefaults.string(forKey: "is_enter_user") == "yes" {
            return true
        }
        if userDefaults.string(forKey: "is_enter_user") == "no"{
            return false
        }
        return false
    }
    
    public static func setStoreUser(){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue("is_enter_user", forKey: "yes")
        userDefaults.synchronize()
    }
    
    public static func setUnstoreUser(){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue("is_enter_user", forKey: "no")
        userDefaults.synchronize()
    }
    
    public static func setUser(_ phone: String){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(phone, forKey: "phone")
        userDefaults.synchronize()
    }
    
    public static func getUser() -> String{
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "phone")!
    }
    
}

