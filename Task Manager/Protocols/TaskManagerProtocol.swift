//
//  TaskManagerProtocol.swift
//  Task Manager
//
//  Created by Adi Mizrahi on 03/02/2025.
//

protocol TaskManagerProtocol {
    var tasks: [Task] { get set }

    func addTask(_ task: Task)
    func updateTask(_ task: Task)
    func filterTasks(by completionStatus: Bool) -> [Task]
}

