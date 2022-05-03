//
//  StorageManager.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 03.05.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    // Open the local-only default realm
    let localRealm = try! Realm()
    
    
    private init() {}
    
    func save(_ taskList: [TaskList]) {
        try! localRealm.write {
            localRealm.add(taskList)
            
        }
    }
}
