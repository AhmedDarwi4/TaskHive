//
//  ViewController.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 28/08/2024.
//

import UIKit
import CoreData

class TasksListVC: UIViewController {
    
    let viewModel = TaskListViewModel()
    
    lazy var celebrationView: CelebrationAnimationView = {
        let view = CelebrationAnimationView(fileName: "Animation - 1725847268538")
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Task Hive"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goForAddTask))
        view.addSubview(tableView)
       view.addSubview(celebrationView)
        NSLayoutConstraint.activate([
            celebrationView.topAnchor.constraint(equalTo: view.topAnchor),
            celebrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            celebrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            celebrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        celebrationView.play { finished in
//            print("Done playing animation")
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAllData()
        tableView.reloadData()
    }
    
    @objc func goForAddTask(){
        let vc = AddNewTaskVC()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension TasksListVC:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(by: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as? SummaryTableViewCell else{
                return UITableViewCell()
            }
            
            let taskSummary = viewModel.getTasksByType()
            cell.configure(completed: taskSummary.complete.description, inCompleted: taskSummary.inComplete.description)
            return cell
            
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else{
                return UITableViewCell()
            }
            
            let task = viewModel.task(by: indexPath.row)
            cell.configure(with: task)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = viewModel.task(by: indexPath.row)
        let completeAction = UIContextualAction(style: .normal, title: task.completed ? "Not completed" : "Completed") { [weak self] action, view, completionHandler in
            self?.completeTask(at: indexPath)
            completionHandler(true)
        }
        completeAction.backgroundColor = task.completed ? UIColor.systemRed : UIColor.systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func completeTask(at indexPath: IndexPath){
        let task = viewModel.task(by: indexPath.row)
        viewModel.toggleCompleted(task: task)
        
        if task.completed{
            celebrationView.isHidden = false
            celebrationView.play { finished in
                self.celebrationView.isHidden = finished
            }
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: 0)], with: .automatic)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
        
        let task = viewModel.task(by: indexPath.row)
        viewModel.deleteItem(task: task)
        tableView.reloadData()
        
    }
}








//-------> For Testing

//class TasksListVC: UIViewController {
//    
//    lazy var addTaskButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Add New task", for: .normal)
//        button.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
//        button.backgroundColor = .purple
//        return button
//    }()
//    
//    lazy var getTaskButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Get Tasks", for: .normal)
//        button.addTarget(self, action: #selector(getTasks), for: .touchUpInside)
//        button.backgroundColor = .blue
//
//        return button
//    }()
//    
//    lazy var toggleCompletedButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Mark task completed", for: .normal)
//        button.addTarget(self, action: #selector(markCompleted), for: .touchUpInside)
//        button.backgroundColor = .systemGreen
//
//        return button
//    }()
//    
//    lazy var deleteTaskButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Delete task", for: .normal)
//        button.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
//        button.backgroundColor = .red
//
//        return button
//    }()
//    
//    lazy var stackView: UIStackView = {
//        let sv = UIStackView()
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.axis = .vertical
//        sv.spacing = 20
//        sv.alignment = .fill
//        sv.distribution = .fill
//        return sv
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemBackground
//        title = "Task Hive"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
//        
//      
//        
//       layout()
//
//    
//    }
//    
//    func layout(){
//        
//        view.addSubview(stackView)
//        
//        stackView.addArrangedSubview(addTaskButton)
//        stackView.addArrangedSubview(getTaskButton)
//        stackView.addArrangedSubview(toggleCompletedButton)
//        stackView.addArrangedSubview(deleteTaskButton)
//        
//        NSLayoutConstraint.activate([
//        
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        
//        ])
//    }
//    
//    @objc func addNewTask(){
//        CoreDataManager.shared.addNewTask(name: "a new task", dueOn: Date().addingTimeInterval(100000))
//    }
//    
//    @objc func getTasks(){
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks{
//            print(task.name ?? "")
//        }
//    }
//    
//    @objc func markCompleted(){
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks{
//            CoreDataManager.shared.toggleCompleted(id: task.id ?? UUID())
//        }
//        
//        let fetchedTasks = CoreDataManager.shared.getAll()
//        for task in tasks{
//            print("\(task.name ?? ""): \(task.completed), \(task.completedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")")
//        }
//        
//    }
//    
//    @objc func deleteTask(){
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks{
//            CoreDataManager.shared.delete(id: task.id ?? UUID())
//        }
//        
//        let fetchedTasks = CoreDataManager.shared.getAll()
//        print(fetchedTasks.count)
//        for task in tasks{
//            print("\(task.name ?? ""): \(task.completed), \(task.completedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")")
//        }
//        
//    }
//
//
//}
