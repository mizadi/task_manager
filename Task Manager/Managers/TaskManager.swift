//
//  TaskManager.swift
//  Task Manager
//
//  Created by Adi Mizrahi on 03/02/2025.
//

import Foundation
class TaskManager: TaskManagerProtocol, TaskPersistable {
    var tasks: [Task] = []

    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks(tasks)
    }

    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.title == task.title }) {
            tasks[index] = task
            saveTasks(tasks)
        }
    }

    func filterTasks(by completionStatus: Bool) -> [Task] {
        return tasks.filter { $0.isCompleted == completionStatus }
    }

    // MARK: - Persistence
    func saveTasks(_ tasks: [Task]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }

    func loadTasks() -> [Task] {
        if let savedTasks = UserDefaults.standard.data(forKey: "tasks") {
            let decoder = JSONDecoder()
            if let loadedTasks = try? decoder.decode([Task].self, from: savedTasks) {
                tasks = loadedTasks
                return loadedTasks
            }
        }
        return []
    }
}
