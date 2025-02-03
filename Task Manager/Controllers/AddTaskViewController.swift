//
//  AddTaskViewController.swift
//  Task Manager
//
//  Created by Adi Mizrahi on 03/02/2025.
//

import Foundation
import UIKit

protocol AddTaskDelegate: AnyObject {
    func didAddTask(_ task: Task)
}

class AddTaskViewController: UIViewController {

    weak var delegate: AddTaskDelegate?
    var taskManager: TaskManager?

    let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Task Title"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let descriptionField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Description (Optional)"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Task", for: .normal)
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Add Task"

        let stackView = UIStackView(arrangedSubviews: [titleField, descriptionField, addButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc func addTask() {
        guard let title = titleField.text, !title.isEmpty else { return }
        let task = Task(title: title, description: descriptionField.text, isCompleted: false)
        delegate?.didAddTask(task)
        navigationController?.popViewController(animated: true)
    }
}
