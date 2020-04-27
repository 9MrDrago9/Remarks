//
//  TableViewController.swift
//  Remarks
//
//  Created by val on 23/4/20.
//  Copyright © 2020 Munis Adilov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentItem = model.notes[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        if (currentItem["isCompleted"] as? Bool) == true{
            cell.accessoryType = .checkmark
        } else {
             cell.accessoryType = .none
        }
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if model.changeStatusCompleted(at: indexPath.row){
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func EditNotesButtonPressed(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() +  0.3) {
            self.tableView.reloadData()
        }    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        model.swapNotes(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing{
            return .none
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    @IBAction func addNotesButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Add note", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Item Name"
        }
        let actionAdd = UIAlertAction(title: "Add", style: .default) { (action) in
            let newNotes = alertController.textFields?[0].text
            if newNotes!.isEmpty{
                return
            } else{
                self.model.addNotes(newNotes: newNotes ?? "" )
                self.tableView.reloadData()
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(actionCancel)
        alertController.addAction(actionAdd)
        self.present(alertController, animated: true, completion: nil)
        tableView.reloadData()
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.removeNotes(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }

}
