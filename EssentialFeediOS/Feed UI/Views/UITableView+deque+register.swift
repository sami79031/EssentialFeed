//
//  UITableView+deque+register.swift
//  EssentialFeediOS
//
//  Created by Sami Ali on 10/13/20.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: Bundle(for: type.self)), forCellReuseIdentifier: className)
    }
}
