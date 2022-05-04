//
//  TasksViewController.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 03.05.2022.
//

import RealmSwift
import Foundation

class TasksViewController: UITableViewController {
    
    var taskList: TaskList!
    
    private var currentTask: Results<Task>!
    private var  completedTask: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = taskList.name
        currentTask = taskList.tasks.filter("isCompleted = false")
        completedTask = taskList.tasks.filter("isCompleted = true")
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Current Tasks" : "Completed Tasks"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTask.count : completedTask.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let task = indexPath.section == 0 ? currentTask[indexPath.row] : completedTask[indexPath.row]
        content.text = task.name
        content.secondaryText = task.note
        cell.contentConfiguration = content

        return cell
    }
    
    @objc private func addButtonPressed() {
        showAlert()
    }
}

extension TasksViewController {
    private func showAlert() {
        let alert = UIAlertController.createAllert(withTitle: "New Task", andMessage: "What do u want to do?")
        
        alert.action { newValue, note in
            self.saveTask(withName: newValue, andNote: note )
        }
        
        present(alert, animated: true)
    }
    
    private func saveTask(withName name: String, andNote note: String) {
        let task = Task(value: [name, note])
        StorageManager.shared.save(task, to: taskList)
        let rowIndex = IndexPath(row: currentTask.index(of: task) ?? 0, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
    }
}
