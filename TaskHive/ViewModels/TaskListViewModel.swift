//
//  TaskListViewModel.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 30/08/2024.
//

import Foundation

class TaskListViewModel{
    var tasks = [TaskViewModel]()
    
    init(){
        getAllData()
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    func getAllData(){
        // fetch data from core data and populate tasks
        tasks = CoreDataManager.shared.getAll().compactMap(TaskViewModel.init)
    }
    
    func numberOfRows(by section: Int)-> Int{
        if section == 0 {
           return 1
        } else{
            return numberOfTasks
        }
    }
    
    func getTasksByType() ->(complete:Int, inComplete:Int){
        let completedCount = tasks.lazy.filter({$0.completed}).count
        let incompleteCount = tasks.lazy.filter({!$0.completed}).count
        return(completedCount,incompleteCount)
    }
    
    func task(by index: Int)-> TaskViewModel{
        tasks[index]
    }
    
    func toggleCompleted(task: TaskViewModel){
        // call core data to toggle completed state
        CoreDataManager.shared.toggleCompleted(id: task.id)
        // then refresh our list
        getAllData()
    }
    
    func deleteItem(task: TaskViewModel){
        // call core data to delete the task
        CoreDataManager.shared.delete(id: task.id)
        // then refresh our list
        getAllData()
    }
    
    
    
}
