//
//  TaskPersistable.swift
//  Task Manager
//
//  Created by Adi Mizrahi on 03/02/2025.
//

protocol TaskPersistable {
    func saveTasks(_ tasks: [Task])
    func loadTasks() -> [Task]
}

