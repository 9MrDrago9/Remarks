//
//  Model.swift
//  Remarks
//
//  Created by val on 23/4/20.
//  Copyright © 2020 Munis Adilov. All rights reserved.
//

import Foundation

class Model {
    
    var notes:[[String: Any]]{
        set {
            UserDefaults.standard.set(newValue, forKey: "notesData")
            UserDefaults.standard.synchronize()
        }
        get {
            if let saveNotes = UserDefaults.standard.array(forKey: "notesData") as?  [[String: Any]]{
                      return saveNotes
                  } else {
                      return []
                  }
        }
    }
    
    func addNotes(newNotes: String, isCompleted: Bool = false) {
        notes.append(["Name": newNotes, "isCompleted": isCompleted])
    }
    
    func removeNotes(at index: Int){
        notes.remove(at: index)
    }
    
    func swapNotes(fromIndex: Int, toIndex: Int){
        let elementToMove = notes[fromIndex]
        notes.remove(at: fromIndex)
        notes.insert(elementToMove, at: toIndex)
    }
    
    func changeStatusCompleted(at item: Int) -> Bool {
        notes[item]["isCompleted"] = !(notes[item]["isCompleted"] as! Bool)
        return notes[item]["isCompleted"] as! Bool
    }
    
}
