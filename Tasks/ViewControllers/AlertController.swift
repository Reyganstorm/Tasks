//
//  AlertController.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 03.05.2022.
//

import UIKit

extension UIAlertController {
    
    static func createAllert(withTitle title: String, andMessage message: String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func action(completion: @escaping(String) -> Void) {
        
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
