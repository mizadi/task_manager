//
//  Task.swift
//  Task Manager
//
//  Created by Adi Mizrahi on 03/02/2025.
//

struct Task: TaskRepresentable, Codable {
    var title: String
    var description: String?
    var isCompleted: Bool
}
