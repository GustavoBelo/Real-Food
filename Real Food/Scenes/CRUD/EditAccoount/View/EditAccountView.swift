//
//  EditAccountView.swift
//  Real Food
//
//  Created by Gustavo Belo on 11/03/22.
//

import UIKit
import FirebaseAuth

class EditAccountView: UIView {
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        if Auth.auth().currentUser?.displayName == nil{
            textField.placeholder = "Adicionar nome"
        } else {
            textField.placeholder = "Seu nome"
        }
        textField.borderStyle = .line
        textField.text = Auth.auth().currentUser?.displayName
        return textField
    }()
    
    var updatePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Alterar senha", for: .normal)
        return button
    }()
    
    var updateNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitle("Alterar nome", for: .normal)
        return button
    }()
    
    var deleteUserButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Excluir usuário", for: .normal)
        return button
    }()
    
    func setupView() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(nameTextField)
        self.addSubview(updatePasswordButton)
        self.addSubview(updateNameButton)
        self.addSubview(deleteUserButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            nameTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            nameTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100),
            
            updatePasswordButton.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 60),
            updatePasswordButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            updatePasswordButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100),
            
            updateNameButton.topAnchor.constraint(equalTo: self.updatePasswordButton.bottomAnchor, constant: 60),
            updateNameButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            updateNameButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100),
            
            deleteUserButton.topAnchor.constraint(equalTo: self.updateNameButton.bottomAnchor, constant: 60),
            deleteUserButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            deleteUserButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100)
        ])
    }
}
