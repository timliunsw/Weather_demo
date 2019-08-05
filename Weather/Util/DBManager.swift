//
//  DBManager.swift
//  Weather
//
//  Created by Tim Li on 5/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import UIKit
import FMDB

class DBManager {
    
    static let shared =  DBManager()

    fileprivate lazy var dbQueue:FMDatabaseQueue = {
        let path = Bundle.main.path(forResource: "cityList", ofType: "sqlite")
        let dbQueue = FMDatabaseQueue(path: path)
        return dbQueue!   
    }()
    
    init() {

    }

    //／MARK:search
    public func queryDBTable(searchString: String) -> [Dictionary<String, String>] {
        var data = [Dictionary<String, String>]()
        let sql = "SELECT * FROM data WHERE (lower(name) LIKE '%\(searchString.lowercased())%') ORDER BY country"
        dbQueue.inDatabase { (db) in
            guard let resultSet = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            while resultSet.next() == true {
                let name = resultSet.string(forColumn: "name")
                let id = resultSet.int(forColumn: "id")
                let country = resultSet.string(forColumn: "country")
                let str = name! + ", " + country!
                data.append(["id":String(id), "name":str])
            }
        }
        return data
        
    }
}
