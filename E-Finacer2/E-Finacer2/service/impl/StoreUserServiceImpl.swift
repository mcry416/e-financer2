//
//  StoreUserServiceImpl.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation

class StoreUserServiceImpl: StoreUserService {
    
    init() {
        let db = SQLiteManager.getInstance().db
        if db.open() {
            print("DATABASE INIT SUCCEED.")
        } else {
            print("ERROR AT: \(db.lastError())")
        }
    }
    
    private func openDatabase(){
        let db = SQLiteManager.getInstance().db
        if db.open() {
            print("DATABASE INIT SUCCEED.")
        } else {
            print("ERROR AT: \(db.lastError())")
        }
    }
    
    func getUser() -> Array<User> {
        self.openDatabase()
        var tempArray: Array<User> = Array<User>()
        let sql = "select * from ef_user oreder by id desc limit 1;"
        let db = SQLiteManager.getInstance().db
        if db.open() {
            if let resultSet = db.executeQuery(sql, withArgumentsIn: []) {
                while resultSet.next() {
                    tempArray.append(User(phone: resultSet.string(forColumn: "phone")!, password: resultSet.string(forColumn: "password")!))
                }
            }
        } else {
            print("ERROR AT \(db.lastError())")
        }
        db.close()
        return tempArray
    }
    
    func setUser(phone: String, password: String) {
        self.openDatabase()
        let sql = "insert into ef_user (phone, password) values(?,?);"
        let db = SQLiteManager.getInstance().db
        if db.open(){
            try! db.executeUpdate(sql, withArgumentsIn: [phone, password])
        } else{
            print("ERROR AT \(db.lastError())")
        }
        db.close()
    }
}

