//
//  ViewController.swift
//  To Do List
//
//  Created by wxt on 2/10/19.
//  Copyright © 2019 BChacks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var defaultData = UserDefaults.standard
    var toDoArray = [String]()
    var toDoNotesArray = [String]()
    //var toDoArray = ["Learn Swift","Build Apps", "Change the world!"]
    //var toDonotesarray = ["Hello", "Hi", "Hey"]

    @IBOutlet weak var Addbarbutton: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.delegate = self
   
        toDoArray = defaultData.stringArray(forKey: "toDoArray") ?? [String]()
        toDoNotesArray = defaultData.stringArray(forKey: "toDoNotesArray") ?? [String]()
    }
    
    func savedefaultData(){
        defaultData.set(toDoArray, forKey: "toDoArray")
        defaultData.set(toDoNotesArray, forKey: "toDoNotesArray")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edititem"{
            let destination = segue.destination as!
                DetailViewController
            let index = tableview.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
            destination.toDoNoteItem = toDoNotesArray[index]
            if let selectPath = tableview.indexPathForSelectedRow{
                tableview.deselectRow(at: selectPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue){
        let sourceViewController = segue.source as!
            DetailViewController
        if let indexPath = tableview.indexPathForSelectedRow{
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            toDoNotesArray[indexPath.row] = sourceViewController.toDoNoteItem!
            tableview.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            toDoNotesArray.append(sourceViewController.toDoNoteItem!)
            tableview.insertRows(at: [newIndexPath], with: .automatic)
            print("Inserted Row")
        
        }
        savedefaultData()
        
    }
    @IBAction func editbarbuttonpressed(_ sender: UIBarButtonItem) {
        if tableview.isEditing {
            tableview.setEditing(false, animated: true)
            Addbarbutton.isEnabled = true
            editBarButton.title = "Edit"
        }else{
            tableview.setEditing(true, animated: true)
            Addbarbutton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        cell.detailTextLabel?.text = toDoNotesArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            toDoArray.remove(at: indexPath.row)
            toDoNotesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            savedefaultData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoArray[sourceIndexPath.row]
        let notetomove = toDoNotesArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoNotesArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
        toDoNotesArray.insert(notetomove, at: destinationIndexPath.row)
//        toDoNotesArray.insert(notetomove, at: sourceIndexPath.row)
        savedefaultData()
    }
    
}

  
