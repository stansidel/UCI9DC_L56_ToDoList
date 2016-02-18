//
//  FirstViewController.swift
//  UCI9DC L56 To Do List
//
//  Created by Stanislav Sidelnikov on 18/02/16.
//  Copyright © 2016 Stanislav Sidelnikov. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ToDoManagerDelegate {
    @IBOutlet weak var tableView: UITableView!
    let toDoManager = (UIApplication.sharedApplication().delegate as! AppDelegate).toDoManager

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoManager.delegate = self
        navigationItem.rightBarButtonItem = editButtonItem()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    deinit {
        toDoManager.delegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoManager.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItem", forIndexPath: indexPath)
        
        if let name = toDoManager.itemAtIndex(indexPath.row) {
            cell.textLabel?.text = name
        }
        
        return cell
    }
    
    private func performActionWithoutTableUpdate(action: (()->AnyObject?)) -> AnyObject? {
        toDoManager.delegate = nil
        let result = action()
        toDoManager.delegate = self
        return result
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if performActionWithoutTableUpdate({self.toDoManager.removeItemAtIndex(indexPath.row)}) as! Bool {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    
    // MARK: - ToDoManagerDelegate
    
    func toDoItemsChanged() {
        tableView.reloadData()
    }
    
    // MARK: - Editing
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}

