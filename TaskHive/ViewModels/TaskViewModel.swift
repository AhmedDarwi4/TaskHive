//
//  TaskViewModel.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 30/08/2024.
//

import Foundation

class TaskViewModel{
    private var task: Task
    init(task: Task) {
        self.task = task
    }
    
    var id: UUID {
        task.id ?? UUID()
    }
    
    var name: String {
        task.name ?? ""
    }
    
    var dueOn: Date {
        task.dueOn ?? Date()
    }
    
    var completedOn: Date {
        task.completedOn ?? Date()
    }
    
    var completed: Bool {
        task.completed
    }
}
