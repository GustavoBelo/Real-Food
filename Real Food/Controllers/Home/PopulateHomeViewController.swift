//
//  PopulateHomeViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 22/12/21.
//

import Foundation
import Firebase

extension HomeViewController {
    func loadPopularDishes() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addPopularDishes(with: snapshotDocuments)
                }
            }
    }
    
    func loadSpecialDishes() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addSpecialDishes(with: snapshotDocuments)
                }
            }
    }
    
    func addPopularDishes(with snapshotDocuments: [QueryDocumentSnapshot]) {
        for doc in snapshotDocuments {
            let data = doc.data()
            let restaurant = doc.documentID
            if self.restaurant == restaurant {
                var category = data[Restaurants.populars] as! [String]
                guard let dishes = data[Restaurants.dishes] as? [String : Any] else { return }
            
                for dish in dishes {
                    if category.contains(dish.key) {
                        guard let newDish = dish.value as? [String : Any] else { return }
                        let finalDish = Dish(id: newDish[Dish.K.id] as? String,
                                             name: newDish[Dish.K.name] as? String,
                                             image: newDish[Dish.K.image] as? String,
                                             description: newDish[Dish.K.description] as? String,
                                             calories: newDish[Dish.K.calories] as? Int ?? 0)
                        
                        self.populars.append(finalDish)
                        DispatchQueue.main.async {
                            self.popularCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func addSpecialDishes(with snapshotDocuments: [QueryDocumentSnapshot]) {
        for doc in snapshotDocuments {
            let data = doc.data()
            let restaurant = doc.documentID
            if self.restaurant == restaurant {
                var category = data[Restaurants.specials] as! [String]
                guard let dishes = data[Restaurants.dishes] as? [String : Any] else { return }
            
                for dish in dishes {
                    if category.contains(dish.key) {
                        guard let newDish = dish.value as? [String : Any] else { return }
                        let finalDish = Dish(id: newDish[Dish.K.id] as? String,
                                             name: newDish[Dish.K.name] as? String,
                                             image: newDish[Dish.K.image] as? String,
                                             description: newDish[Dish.K.description] as? String,
                                             calories: newDish[Dish.K.calories] as? Int ?? 0)
                        
                        self.specials.append(finalDish)
                        DispatchQueue.main.async {
                            self.specialCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
