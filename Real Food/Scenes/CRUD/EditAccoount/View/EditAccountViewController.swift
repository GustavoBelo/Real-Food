//
//  EditAccountViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 11/03/22.
//

import UIKit
import HideKeyboardWhenTappedAround
import Firebase

class EditAccountViewController: UIViewController {
    
    private let editAccountView: EditAccountView = {
        return EditAccountView()
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = editAccountView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupView() {
        self.editAccountView.setupView()
        editAccountView.nameTextField.delegate = self
        editAccountView.updatePasswordButton.addTarget(self, action: #selector(updatePasswordEmail), for: .touchUpInside)
        editAccountView.updateNameButton.addTarget(self, action: #selector(updateName), for: .touchUpInside)
        editAccountView.deleteUserButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
    }
    
    @objc
    private func updatePasswordEmail() {
        let auth = Auth.auth()
        if let userEmail = auth.currentUser?.email {
            auth.sendPasswordReset(withEmail: userEmail) { error in
                if let e = error {
                    print(e)
                }
            }
        }
    }
    
    @objc
    private func updateName() {
        let auth = Auth.auth()
        if let newName = editAccountView.nameTextField.text,
           newName != auth.currentUser?.displayName {
            let changeRequest = auth.currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = newName
            changeRequest?.commitChanges { error in
                if let e = error {
                    print(e)
                }
            }
        }
    }
    
    @objc
    private func deleteUser() {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let e = error {
                print(e)
            } else {
                self.navigationController?.goToInitial()
            }
        }
    }
}

extension EditAccountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
