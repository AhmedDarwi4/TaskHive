//
//  UIView+EXT.swift
//  TaskHive
//
//  Created by Ahmed Darwish on 05/09/2024.
//

import UIKit

extension UIView{
    
    func addSubviews(_ views: UIView ...){
        
        for view in views{
            addSubview(view)
        }
    }
    
}
