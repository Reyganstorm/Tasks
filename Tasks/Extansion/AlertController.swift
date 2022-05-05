//
//  AlertController.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 03.05.2022.
//

import UIKit

class AlertController: UIAlertController {
    var doneButton = "Save"
    
    static func createAllert(withTitle title: String, andMessage message: String) -> AlertController {
        AlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func action(with taskList: TaskList?, completion: @escaping(String) -> Void) {
        
        if taskList != nil { doneButton = "Update"}
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else {return}
            guard !newValue.isEmpty else {return}
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "List Name"
            textField.text = taskList?.name
        }
    }
    
    func action(completion: @escaping(String, String) -> Void) {
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else {return}
            guard !newValue.isEmpty else {return}
            
            if let note = self.textFields?.last?.text, !note.isEmpty {
                completion(newValue, note)
            } else {
                completion(newValue, "")
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "List Name"
        }
        addTextField { textField in
            textField.placeholder = "Note"
        }
    }
}
