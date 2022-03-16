//
//  MenuTableViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 09/03/22.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    var menuNavigationController: UINavigationController!
    
    private let menuView: MenuView = {
       return MenuView()
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.menuView.menuTableView.delegate = self
        self.menuView.menuTableView.dataSource = self
        self.menuView.setupView()
        setupSheetCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTableView()
    }
    
    private func setupSheetCard() {
        self.modalPresentationStyle = .pageSheet
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium()]
        }
    }
    
    override func loadView() {
        view = menuView
    }
    
    private func reloadTableView() {
        self.menuView.menuTableView.reloadData()
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.cellId, for: indexPath) as? MenuTableViewCell{
            setupCell(to: cell, at: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setActionCell(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setupCell(to cell: MenuTableViewCell, at indexPath: Int) {
        switch indexPath {
        case 0:
            cell.setupCell(icon: "person", title: "Conta", at: indexPath)
        case 1:
            cell.setupCell(icon: "escape", title: "Sair", at: indexPath)
        default: break
        }
    }
    
    func setActionCell(at indexPath: Int) {
        switch indexPath {
        case 0:
            editAccount()
        case 1:
            loggout()
        default: break
        }
    }
    
    private func editAccount() {
        self.dismiss(animated: true)
        let nextViewController = EditAccountViewController()
        self.menuNavigationController.pushViewController(nextViewController, animated:true) 
    }
    
    private func loggout() {
        if Auth.auth().currentUser?.email != nil {
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true)
                menuNavigationController.goToInitial()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
    }
}
