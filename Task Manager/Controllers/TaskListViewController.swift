//
//  TaskListViewController.swift
//  Task Manager
//
//  Created by Adi Mizrahi on 03/02/2025.
//

import Foundation
import UIKit

class TaskListViewController: UITableViewController {

    var taskManager = TaskManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        taskManager.tasks = taskManager.loadTasks()
    }

    func setupUI() {
        title = "Task Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))

        // Use a subtitle style cell to show both title and description
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
    }


    @objc func addTask() {
        let addTaskVC = AddTaskViewController()
        addTaskVC.taskManager = taskManager
        addTaskVC.delegate = self
        navigationController?.pushViewController(addTaskVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = taskManager.tasks[indexPath.row]

        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.description?.isEmpty == false ? task.description : "No description"
        cell.accessoryType = task.isCompleted ? .checkmark : .none

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = taskManager.tasks[indexPath.row]

        let detailVC = TaskDetailViewController()
        detailVC.task = selectedTask

        navigationController?.pushViewController(detailVC, animated: true)
    }

    // MARK: - Swipe to Delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskManager.tasks.remove(at: indexPath.row)
            taskManager.saveTasks(taskManager.tasks)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension TaskListViewController: AddTaskDelegate {
    func didAddTask(_ task: Task) {
        taskManager.addTask(task)
        tableView.reloadData()
    }
}
