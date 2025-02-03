# Task Manager App (Protocol-Oriented Programming in Swift)

## Overview
This is a sample **Task Manager** app built with **UIKit** to demonstrate **Protocol-Oriented Programming (POP)** in Swift. The app allows users to:
- Add tasks with a title and optional description.
- Mark tasks as completed.
- Delete tasks by swiping.
- View task details.
- Persist tasks using `UserDefaults`.

## Key Concepts
This project follows **Protocol-Oriented Programming (POP)** principles by using:

### 1. **TaskRepresentable** (Defines Task Structure)
```swift
protocol TaskRepresentable {
    var title: String { get }
    var description: String? { get }
    var isCompleted: Bool { get set }
}
```

### 2. **TaskPersistable** (Handles Data Persistence)
```swift
protocol TaskPersistable {
    func saveTasks(_ tasks: [Task])
    func loadTasks() -> [Task]
}
```

### 3. **TaskManagerProtocol** (Manages Task Operations)
```swift
protocol TaskManagerProtocol {
    var tasks: [Task] { get set }
    func addTask(_ task: Task)
    func updateTask(_ task: Task)
    func filterTasks(by completionStatus: Bool) -> [Task]
}
```

## Implementation
### **Task Model**
```swift
struct Task: TaskRepresentable, Codable {
    var title: String
    var description: String?
    var isCompleted: Bool
}
```

### **Task Manager**
Handles task storage and retrieval using `UserDefaults`.
```swift
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
```

## UI Implementation
### **Task List Screen (`TaskListViewController`)**
- Displays tasks in a table view.
- Allows users to mark tasks as completed.
- Supports swipe-to-delete.

### **Add Task Screen (`AddTaskViewController`)**
- Users enter a title and description.
- Task is added and saved.

### **Task Detail Screen (`TaskDetailViewController`)**
- Shows task details when a task is tapped.

## Running the Project
1. Clone the repository.
2. Open `TaskManager.xcodeproj` in Xcode.
3. Run the app on a simulator or device.

## Future Improvements
- Implement filtering (e.g., show only completed tasks).
- Use CoreData instead of `UserDefaults` for persistence.
- Add unit tests for `TaskManager`.

## Conclusion
This project showcases how **Protocol-Oriented Programming (POP)** helps in creating **modular, reusable, and scalable** code. The use of protocols promotes **composition over inheritance**, making the codebase cleaner and more maintainable.

