//
//  ViewController.swift
//  Tasks
//
//  Created by Руслан Штыбаев on 03.05.2022.
//

import RealmSwift

class MainViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    private var taskLists: Results<TaskList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTempData()
        taskLists = StorageManager.shared.localRealm.objects(TaskList.self)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        showAlert()
    }
    
    private func createTempData() {
        DataManager.shared.createTempData {
            self.tableView.reloadData()
        }
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let taskList = taskLists[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = taskList.name
        content.secondaryText = "\(taskList.tasks.count)"
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        guard let tasksVC = segue.destination as? TasksViewController else {return}
        let taskList = taskLists[indexPath.row]
        tasksVC.taskList = taskList
        
    }
    
    
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let taskList = taskLists[indexPath.row]
        
        let delete = UIContextualAction(
            style: .destructive,
            title: "Delete") { _, _, _ in
                StorageManager.shared.delete(taskList)
                tableView.deleteRows(at: [indexPath], with: .automatic )
            }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
}

extension MainViewController {
    private func showAlert() {
        let alert = UIAlertController.createAllert(withTitle: "New Task", andMessage: "What do u want to do?")
        
        alert.action { newValue in
            self.save(newValue)
        }
        
        present(alert, animated: true)
    }
    
    private func save(_ taskList: String) {
        let taskList = TaskList(value: [taskList])
        StorageManager.shared.save(taskList)
        let rowIndex = IndexPath(row: taskLists.index(of: taskList) ?? 0, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
    }
}

