//
//  TasksViewController.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 03.05.2022.
//

import UIKit

class TasksViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Current" : "Completed"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)


        return cell
    }
    
    private func addButtonPressed() {
        showAlert()
    }
}

extension TasksViewController {
    private func showAlert() {
        let alert = UIAlertController.createAllert(withTitle: "New Task", andMessage: "What do u want to do?")
        
        alert.action { newValue, note in
            
        }
        
        present(alert, animated: true)
    }
}
