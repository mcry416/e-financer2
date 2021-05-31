//
//  SQLiteManager.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation
import FMDB
 
class SQLiteManager: NSObject {
     
    // Create Single instance.
    private static let manger: SQLiteManager = SQLiteManager()
    class func getInstance() -> SQLiteManager {
        return manger
    }
     
    // Database's name.
    private let dbName = "ef_user.db"
     
    // URL
    lazy var dbURL: URL = {
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask,
                 appropriateFor: nil, create: true)
            .appendingPathComponent(dbName)
        print("------>Database URL：", fileURL)
        return fileURL
    }()
     
    // FMDatabase Object.
    lazy var db: FMDatabase = {
        let database = FMDatabase(url: dbURL)
        return database
    }()
     
    // FMDatabaseQueue Object.
    lazy var dbQueue: FMDatabaseQueue? = {
        let databaseQueue = FMDatabaseQueue(url: dbURL)
        return databaseQueue
    }()
}
