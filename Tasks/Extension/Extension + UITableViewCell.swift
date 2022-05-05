//
//  Extension + UITableViewCell.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 05.05.2022.
//

import UIKit

extension UITableViewCell {
    func configuration(with taskList: TaskList) {
        let currentTasks = taskList.tasks.filter("isCompleted = false")
        var content = defaultContentConfiguration()
        
        content.text = taskList.name
        
        if taskList.tasks.isEmpty {
            content.secondaryText = "0"
            accessoryType = .none
        } else if currentTasks.isEmpty {
            content.secondaryText = nil
            accessoryType = .checkmark
        } else {
            content.secondaryText = "\(currentTasks.count)"
            accessoryType = .none
        }
         contentConfiguration = content
    }
}
