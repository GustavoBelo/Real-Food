//
//  DishDetailViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 13/12/21.
//

import UIKit
import HideKeyboardWhenTappedAround

class DishDetailViewController: UIViewController {
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var tableField: UITextField!
    @IBAction func placeOrderBtntClicked(_ sender: UIButton) {
        
    }
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var dish: Dish!
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
}
