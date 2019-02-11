//
//  DetailViewController.swift
//  To Do List
//
//  Created by wxt on 2/10/19.
//  Copyright © 2019 BChacks. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var savebarButton:UIBarButtonItem!
    @IBOutlet weak var toDonoteview: UITextView!
    @IBOutlet weak var toDoField: UITextField!
    var toDoItem: String?
    var toDoNoteItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDoItem = toDoItem{
            toDoField.text = toDoItem
            self.navigationItem.title = "Edit To Do Item"
        } else {
            self.navigationItem.title = "New To Do Item"
        }
        if let toDoNoteItem = toDoNoteItem{
            toDonoteview.text = toDoNoteItem
        }
        enableDisableSaveButton()
        toDoField.becomeFirstResponder()

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindfromsave"{
            toDoItem = toDoField.text
            toDoNoteItem = toDonoteview.text
        }
    }
    func enableDisableSaveButton(){
        if let todoFieldcount = toDoField.text?.count, todoFieldcount > 0 {
            savebarButton.isEnabled = true
        }else{
            savebarButton.isEnabled = false
        }
    }
    
    @IBAction func todoFieldChange(_ sender: UITextField) {
        enableDisableSaveButton()
    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    

}
