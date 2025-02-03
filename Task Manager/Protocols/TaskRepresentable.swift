//
//  TaskRepresentable.swift
//  Task Manager
//
//  Created by Adi Mizrahi on 03/02/2025.
//

protocol TaskRepresentable {
    var title: String { get }
    var description: String? { get }
    var isCompleted: Bool { get set }
}
