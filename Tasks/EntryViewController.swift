//
//  EntryViewController.swift
//  Tasks
//
//  Created by Madhusha Prasad on 2024-01-24.
//

import UIKit

class EntryViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet var field : UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self,action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        guard let text = field.text, !text.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        guard let count = UserDefaults.standard.integer(forKey: "count") as? Int else {
            print("Error retrieving count from UserDefaults.")
            return
        }

        let newCount = count + 1

        UserDefaults.standard.setValue(newCount, forKey: "count")
        UserDefaults.standard.setValue(text, forKey: "task_\(newCount)")

        // Show success alert
        let successAlert = UIAlertController(title: "Success", message: "Task added successfully", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.update?()
            self.navigationController?.popViewController(animated: true)
        })

        present(successAlert, animated: true, completion: nil)
    }


}
