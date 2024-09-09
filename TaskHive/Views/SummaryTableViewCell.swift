//
//  SummaryTableViewCell.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 07/09/2024.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    static let identifier = String(describing: SummaryTableViewCell.self)
    
    lazy var stackView: UIStackView = {
       let stackView                                        = UIStackView()
        stackView.axis                                      = .vertical
        stackView.alignment                                 = .fill
        stackView.spacing                                   = 8
        stackView.backgroundColor                           = .secondarySystemBackground
        stackView.isLayoutMarginsRelativeArrangement        = true
        stackView.directionalLayoutMargins                  = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.layer.cornerRadius                        = 16
        stackView.clipsToBounds                             = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let completedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let toDoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupViews()
    }
    
    func setupViews(){
        selectionStyle = .none
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(completedLabel)
        stackView.addArrangedSubview(toDoLabel)
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(completed: String, inCompleted: String){
        completedLabel.text = "✅ Completed: \(completed)"
        toDoLabel.text      = "📋 ToDo: \(inCompleted)"
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
