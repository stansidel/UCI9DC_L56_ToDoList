//
//  ToDoManager.swift
//  UCI9DC L56 To Do List
//
//  Created by Stanislav Sidelnikov on 18/02/16.
//  Copyright © 2016 Stanislav Sidelnikov. All rights reserved.
//

import Foundation

protocol ToDoManagerDelegate {
    func toDoItemsChanged()
}

class ToDoManager {
    let SETTINGS_NAME = "ToDoArray"
    
    var delegate: ToDoManagerDelegate?
    
    var count: Int {
        get {
            return items.count
        }
    }
    
    private var _items: [String]?
    var items: [String] {
        get {
            if _items == nil {
                if let savedItems = NSUserDefaults.standardUserDefaults().objectForKey(SETTINGS_NAME) as? [String] {
                    _items = savedItems
                } else {
                    _items = [String]()
                }
            }
            
            return _items!
        }
    }
    
    private func saveItems(array: [String]) {
        NSUserDefaults.standardUserDefaults().setObject(array, forKey: SETTINGS_NAME)
        _items = array
        delegate?.toDoItemsChanged()
    }
    
    func addItem(name: String) {
        var array = items
        array.append(name)
        saveItems(array)
    }
    
    func removeItemAtIndex(index: Int) -> Bool {
        guard index < items.count else {
            return false
        }
        var array = items
        array.removeAtIndex(index)
        saveItems(array)
        return true
    }
    
    func itemAtIndex(index: Int) -> String? {
        if items.count > index {
            return items[index]
        } else {
            return nil
        }
    }
}