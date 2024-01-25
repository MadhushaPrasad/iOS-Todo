//
//  ViewController.swift
//  Tasks
//
//  Created by Madhusha Prasad on 2024-01-24.
//

import UIKit

class ViewController: UIViewController, TaskViewControllerDelegate {
    
    @IBOutlet var tableView : UITableView!
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // setup
        if !UserDefaults.standard.bool(forKey: "setup") {
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(0, forKey: "count")  // Set count as an integer
        }

        
        // Get all current tasks
        updateTasks()
    }
    
    func updateTasks(){
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
    }
    
    func taskDeleted() {
        updateTasks()
        tableView.reloadData()
    }
    
    
    @IBAction func didTapSave(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController!.pushViewController(vc, animated: true)
    }


}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        vc.delegate = self  // Ensure this line is correct
        navigationController!.pushViewController(vc, animated: true)
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}

