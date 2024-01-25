//
//  TaskViewController.swift
//  Tasks
//
//  Created by Madhusha Prasad on 2024-01-24.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var task: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self,action: #selector(deleteTask))
    }
    
    
    @objc func deleteTask(){
        guard let currentTask = task else {
            return
        }

        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }

        // Find the position of the task to be deleted
        var taskPositionToDelete: Int?
        for x in 1...count {
            if let taskInUserDefaults = UserDefaults().value(forKey: "task_\(x)") as? String,
               taskInUserDefaults == currentTask {
                taskPositionToDelete = x
                break
            }
        }

        // Remove the task from UserDefaults
        if let position = taskPositionToDelete {
            UserDefaults().setValue(nil, forKey: "task_\(position)")

            // Update the count
            let newCount = count - 1
            UserDefaults().setValue(newCount, forKey: "count")

            navigationController?.popViewController(animated: true)
        }
    }

}
