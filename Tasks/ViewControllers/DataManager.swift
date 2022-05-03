//
//  DataManager.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 03.05.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(_ completion: @escaping() -> Void ) {
        if !UserDefaults.standard.bool(forKey: "completed") {
            UserDefaults.standard.set(true, forKey: "completed")
            
           let moviesList = TaskList(value: ["Movies List", Date(), [["Avatar"], ["Dead Note", "anime", Date(), true]]])
            
            let shopingList = TaskList()
            shopingList.name = "Shoping List"
            
            let milk = Task()
            milk.name = "Milk"
            milk.note = "2L"
            
            let bread = Task(value: ["Bread", "", Date(), true])
            let apples = Task(value: ["name" : "Apples", "note" : "2Kg"])
            
            shopingList.tasks.append(milk)
            shopingList.tasks.insert(contentsOf: [bread, apples], at: 1)
            
            DispatchQueue.main.async {
                StorageManager.shared.save([shopingList, moviesList])
                completion()
            }
        }
    }
}
