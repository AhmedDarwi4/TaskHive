//
//  AddNewTaskViewModel.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 31/08/2024.
//

import Foundation

class AddNewTaskViewModel{
    
    func addTask(name: String, dueOn: Date){
        // call core data and add a record for task
        
        CoreDataManager.shared.addNewTask(name: name, dueOn: dueOn)
        
    }
}
