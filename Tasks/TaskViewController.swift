//
//  TaskViewController.swift
//  Tasks
//
//  Created by Madhusha Prasad on 2024-01-24.
//

// TaskViewController.swift

import UIKit

class TaskViewController: UIViewController {
    
    weak var delegate: TaskViewControllerDelegate?
    
    @IBOutlet var label: UILabel!
    
    var task: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask(){
        guard let currentTask = task else {
            return
        }

        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }

        var taskPositionToDelete: Int?
        for x in 1...count {
            if let taskInUserDefaults = UserDefaults().value(forKey: "task_\(x)") as? String,
               taskInUserDefaults == currentTask {
                taskPositionToDelete = x
                break
            }
        }

        if let position = taskPositionToDelete {
            let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this task?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                // Remove the task from UserDefaults
                UserDefaults().setValue(nil, forKey: "task_\(position)")

                // Update the count
                let newCount = count - 1
                UserDefaults().setValue(newCount, forKey: "count")

                // Notify the delegate that a task has been deleted
                self.delegate?.taskDeleted()

                self.navigationController?.popViewController(animated: true)
            }))

            present(alert, animated: true, completion: nil)
        }

    }

}
