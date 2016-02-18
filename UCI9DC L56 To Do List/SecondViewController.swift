//
//  SecondViewController.swift
//  UCI9DC L56 To Do List
//
//  Created by Stanislav Sidelnikov on 18/02/16.
//  Copyright © 2016 Stanislav Sidelnikov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextField {
            addToDo(textField)
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addToDo(sender: AnyObject) {
        guard let name = nameTextField.text where !name.isEmpty else {
            return
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toDoManager.addItem(name)
        nameTextField.text = nil
        tabBarController?.selectedIndex = 0
    }
}

