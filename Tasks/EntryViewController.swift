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
        
        
        // setup
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set("0", forKey: "count")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask(){
        guard let text = field.text, text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().setValue(newCount, forKey: "count")
        UserDefaults().setValue(text, forKey: "task_\(newCount)")
        
        
    }

}
