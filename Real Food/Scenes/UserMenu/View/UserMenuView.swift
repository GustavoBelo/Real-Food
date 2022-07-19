//
//  UserMenuView.swift
//  Real Food
//
//  Created by Gustavo Belo on 09/03/22.
//

import UIKit

class UserMenuView: UIView {
        
    let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func setupView() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        setTableView()
        addSubviews()
        setupConstraints()
    }
    
    private func setTableView() {
        menuTableView.register(UserMenuTableViewCell.self, forCellReuseIdentifier: UserMenuTableViewCell.identifier)
    }
    
    private func addSubviews() {
        self.addSubview(menuTableView)
    }
    
    private func setupConstraints() {
        menuTableView.bindEdgesToSuperview()
    }
}
