//
//  MenuViewModel.swift
//  Real Food
//
//  Created by Gustavo Belo on 15/07/22.
//

import Foundation
import Firebase

enum MenuViewModelState: Equatable {
    case categoryData
    case loadingCategoryData
    case popularData
    case loadingPopularData
    case specialData
    case loadingSpecialData
    case error(String)
}

protocol MenuViewModelProtocol: MenuViewModel {
    var state: Bindable<MenuViewModelState?> { get }
    func loadCategories()
}

class MenuViewModel: MenuViewModelProtocol {
    var state: Bindable<MenuViewModelState?> = Bindable(nil)
    private let db = Firestore.firestore()
    
    private var restaurantID: String
    private var branchID: String
    
    init(restaurantID: String, branchID: String) {
        self.restaurantID = restaurantID
        self.branchID = branchID
    }
    
    var categoryArray: [DishCategory] = []
    var popularsArray: [Dish] = []
    var specialsArray: [Dish] = []
    
    private typealias InsideDocumentFunction = (_ documents: [QueryDocumentSnapshot]) -> Void
    
    private func getDocumentsFromBranch(andDo: @escaping InsideDocumentFunction) {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    self.state.value = .error(e.localizedDescription)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let restaurantID = doc.documentID
                        if self.restaurantID == restaurantID {
                            self.db.collection("Restaurants/\(restaurantID)/Branches").getDocuments { (querySnapshot, err) in
                                if let err = err {
                                    self.state.value = .error(err.localizedDescription)
                                } else {
                                    andDo(querySnapshot!.documents)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    private func getDishes(andDo: @escaping InsideDocumentFunction) {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    self.state.value = .error(e.localizedDescription)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let restaurantID = doc.documentID
                        if self.restaurantID == restaurantID {
                            self.db.collection("Restaurants/\(restaurantID)/Dishes").getDocuments { (querySnapshot, err) in
                                if let err = err {
                                    self.state.value = .error(err.localizedDescription)
                                } else {
                                    andDo(querySnapshot!.documents)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    private func getCategories(_ branches: [QueryDocumentSnapshot]) {
        categoryArray.removeAll()
        for branch in branches {
            guard let categories = branch.data()[Restaurants.categories] as? [String : Any] else { return }
            for category in categories  {
                guard let fullCategory = category.value as? [String : Any] else { return }
                let newCategory = DishCategory(id: fullCategory[DishCategory.K.id] as? String,
                                               name: fullCategory[DishCategory.K.name] as? String,
                                               image: fullCategory[DishCategory.K.image] as? String,
                                               dishes: fullCategory[DishCategory.K.dishes] as! [String])
                self.categoryArray.append(newCategory)
                if categoryArray.count == categories.count {
                    self.state.value = .categoryData
                }
            }
        }
    }
    
    func loadCategories() {
        state.value = .loadingCategoryData
        getDocumentsFromBranch(andDo: getCategories(_:))
    }
    
    func loadPopulars() {
        state.value = .loadingPopularData
        getDocumentsFromBranch(andDo: getPopulars(_:))
    }
    
    func loadSpecials() {
        state.value = .loadingPopularData
        getDocumentsFromBranch(andDo: getSpecials(_:))
    }
    
    private func getPopulars(_ branches: [QueryDocumentSnapshot]) {
        popularsArray.removeAll()
        for branch in branches {
            guard let populars = branch.data()[Restaurants.populars] as? [String] else { return }
            self.getDishes { documents in
                for popular in populars {
                    for doc in documents {
                        if doc.documentID == popular {
                            guard let image = doc[Dish.K.image] as? String else { return }
                            let dish = Dish(id: doc.documentID,
                                            name: doc[Dish.K.name] as? String,
                                            description: doc[Dish.K.description] as? String,
                                            ARModel: doc[Dish.K.ARModel] as? String,
                                            price: doc[Dish.K.price] as? String ?? "0",
                                            image: image)
                            self.popularsArray.append(dish)
                            if self.popularsArray.count == populars.count {
                                self.state.value = .popularData
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func getSpecials(_ branches: [QueryDocumentSnapshot]) {
        specialsArray.removeAll()
        for branch in branches {
            guard let specials = branch.data()[Restaurants.specials] as? [String] else { return }
            self.getDishes { documents in
                for special in specials {
                    for doc in documents {
                        if doc.documentID == special {
                            guard let image = doc[Dish.K.image] as? String else { return }
                            let dish = Dish(id: doc.documentID,
                                            name: doc[Dish.K.name] as? String,
                                            description: doc[Dish.K.description] as? String,
                                            ARModel: doc[Dish.K.ARModel] as? String,
                                            price: doc[Dish.K.price] as? String ?? "0",
                                            image: image)
                            self.specialsArray.append(dish)
                            if self.specialsArray.count == specials.count {
                                self.state.value = .specialData
                            }
                        }
                    }
                }
            }
        }
    }
}

