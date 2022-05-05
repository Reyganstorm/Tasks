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
    
    // MARK: - TaskList
    func save(_ taskLists: [TaskList]) {
        write {
            localRealm.add(taskLists)
        }
    }
    
    func save(_ taskList: TaskList) {
        write {
            localRealm.add(taskList)
        }
    }
    
    // MARK: - Tasks
    func save(_ task: Task, to taskList: TaskList ) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    // MARK: - Delete
    
    func delete(_ taskList: TaskList) {
        write {
            localRealm.delete(taskList.tasks)
            localRealm.delete(taskList)
        }
    }
    
    func delete(_ task: Task) {
        write {
            localRealm.delete(task)
        }
    }
    
    // MARK: - Edit
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }
    
    func edit(_ task: Task, to newName: String, with newNote: String) {
        write {
            task.name = newName
            task.note = newNote
        }
    }
    
    // MARK: - Done
    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isCompleted")
        }
    }
    
    func done(_ task: Task) {
        write {
            task.isCompleted.toggle()
        }
    }
    
    
    private func write(completion: ()-> Void) {
        do {
            try localRealm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
