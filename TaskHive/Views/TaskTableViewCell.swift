//
//  TaskTableViewCell.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 06/09/2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell{
    
    static let identifier = String(describing: TaskTableViewCell.self)

    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font          = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var dueOrCompletedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var completedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var taskView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth  = 2
        view.layer.borderColor  = UIColor.systemGray.cgColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews(){
        selectionStyle = .none
        contentView.addSubviews(taskView)
        taskView.addSubviews(taskNameLabel,dueOrCompletedLabel,completedLabel)
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            taskView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            taskView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        
            taskNameLabel.topAnchor.constraint(equalTo: taskView.topAnchor, constant: 8),
            taskNameLabel.leadingAnchor.constraint(equalTo: taskView.leadingAnchor, constant: 8),
            taskNameLabel.trailingAnchor.constraint(equalTo: taskView.trailingAnchor, constant: -8),
            
            dueOrCompletedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            dueOrCompletedLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor),
            dueOrCompletedLabel.bottomAnchor.constraint(equalTo: taskView.bottomAnchor, constant: -8),
            
            completedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            completedLabel.trailingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor),
            completedLabel.bottomAnchor.constraint(equalTo: taskView.bottomAnchor, constant: -8),

            
        ])
    }
    
    
    func configure(with task: TaskViewModel){
        
        let attributedString = NSMutableAttributedString(string: task.name)
        
        if task.completed{
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
            
            taskNameLabel.font          = UIFont.italicSystemFont(ofSize: 16)
            taskView.layer.borderColor  = UIColor.green.cgColor
            completedLabel.text         =  "Completed"
            completedLabel.textColor    =  UIColor.green
            dueOrCompletedLabel.text    = "Completed on: \(task.completedOn.formatted(date: .abbreviated, time: .omitted))"
            
        } else{
            taskNameLabel.font          = .systemFont(ofSize: 16, weight: .bold)
            taskView.layer.borderColor  = UIColor.systemGray.cgColor
            completedLabel.text         = "Not completed"
            completedLabel.textColor    = UIColor.systemRed
            dueOrCompletedLabel.text    = "Due on: \(task.dueOn.formatted(date: .abbreviated, time: .omitted))"
        }
        
        taskNameLabel.attributedText = attributedString
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
