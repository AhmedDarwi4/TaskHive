//
//  AddTaskVC.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 05/09/2024.
//

import UIKit

class AddNewTaskVC: UIViewController {
    
    lazy var taskNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Task Name"
        return label
    }()
    
    lazy var taskNameTextfield: UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter task name"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var dueOnLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Due On"
        return label
    }()
    
    lazy var datePicker:UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.datePickerMode                            = .date
        datePicker.locale                                    = .current
        datePicker.minimumDate                               = Date()
        datePicker.preferredDatePickerStyle                  = .compact
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    
    let viewModel = AddNewTaskViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
          setupViews()
    }
    
    func setupViews(){
        title = "Add New Task"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        configureUI()
    }
    
    
    

    
    func configureUI(){
        view.addSubviews(
            taskNameLabel,
            taskNameTextfield,
            dueOnLabel,
            datePicker
        )
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            
            taskNameTextfield.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskNameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            taskNameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            datePicker.topAnchor.constraint(equalTo: taskNameTextfield.bottomAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: taskNameTextfield.trailingAnchor),
            
            dueOnLabel.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskNameTextfield.leadingAnchor),
            
        
        ])
    }
    
    @objc func saveTask(){
        
        guard let taskName = taskNameTextfield.text, !taskName.isEmpty else{
            let alert = UIAlertController(title: "Error", message: "Task name can`t be empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            
            return
        }
        
        let dueOn = datePicker.date
        viewModel.addTask(name: taskName, dueOn: dueOn)
        navigationController?.popViewController(animated: true)
        
    }
  

}
