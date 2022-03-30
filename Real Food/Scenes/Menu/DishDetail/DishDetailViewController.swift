//
//  DishDetailViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 13/12/21.
//

import UIKit
import HideKeyboardWhenTappedAround
import Firebase

class DishDetailViewController: UIViewController {
    private let db = Firestore.firestore()
    
    @IBOutlet weak var ARDishBtn: UIButton!
    @IBOutlet private weak var dishImageView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var caloriesLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    @IBOutlet private weak var tableField: UITextField!
    
    var dish: Dish!
    var restaurant: String!
    private var dateField = Date().timeIntervalSince1970
    
    @IBAction func ARDishBtnClicked(_ sender: UIButton) {
        if dish.ARModel != nil {
            let controller = ARDishViewController.instantiate()
            controller.dish = dish.ARModel
            controller.restaurant = restaurant
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    @IBAction func placeOrderBtnClicked(_ sender: UIButton) {
        if let sender = Auth.auth().currentUser?.email,
           let table = tableField.text,
           let restaurant = restaurant,
           (table.rangeOfCharacter(from: NSCharacterSet.letters) != nil) ||
            (table.rangeOfCharacter(from: NSCharacterSet.alphanumerics) != nil) {
            createNewOrder(restaurant: restaurant, sender: sender, at: table, on: dateField)
            tableField.text = nil
        }
        
    }
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var bottomStackViewHeight: CGFloat?
    
    private func populateView() {
        dish.setup(title: titleLbl,
                   imageView: dishImageView,
                   calories: caloriesLbl,
                   description: descriptionLbl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        populateView()
        if dish.ARModel == nil {
            ARDishBtn.isHidden.toggle()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let deviceOrientation = UIDevice.current.orientation
        if deviceOrientation.isPortrait{
            bottomStackViewHeight = bottomStackView.layer.frame.height
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let deviceOrientation = UIDevice.current.orientation
        let constraint = self.applyPortraitConstraint()
        if deviceOrientation.isPortrait {
            bottomStackView.addConstraint(constraint)
        } else {
            bottomStackView.removeConstraint(constraint)
        }
    }
    
    private func applyPortraitConstraint() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: bottomStackView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: bottomStackViewHeight ?? CGFloat(250))
    }
    
    private func createNewOrder(restaurant: String, sender: String, at table: String, on dateField: TimeInterval) {
        db.collection(Order.K.identifierGroup).addDocument(data: [
            Order.K.restaurant : restaurant,
            Order.K.date : dateField,
            Order.K.identifier : [
                Order.K.sender : sender,
                Order.K.table : table,
                Dish.K.dish : [
                    Dish.K.id: dish.id!,
                    Dish.K.image: dish.image!,
                    Dish.K.description : dish.description!,
                    Dish.K.name : dish.name!,
                    Dish.K.ARModel : dish.ARModel as Any,
                    Dish.K.calories : dish.calories ?? 0
                ]
            ]
        ]) { (error) in
            if let e = error {
                print(e.localizedDescription)
            }
        }
    }
}
