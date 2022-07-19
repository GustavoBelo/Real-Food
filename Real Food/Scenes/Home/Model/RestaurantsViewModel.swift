//
//  RestaurantsViewModel.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/07/22.
//

import Foundation
import Firebase

enum RestaurantsViewModelState {
    case data
    case loading
    case error(String)
}

enum CellType {
    case shimmerCell
    case dataCell
}

protocol RestaurantsViewModelProtocol: RestaurantsViewModel {
    var state: Bindable<RestaurantsViewModelState?> { get }
    func setupCellsData()
}

class RestaurantsViewModel: RestaurantsViewModelProtocol {
    var state: Bindable<RestaurantsViewModelState?> = Bindable(nil)
    var cellType: Bindable<CellType?> = Bindable(nil)
    
    let db = Firestore.firestore()
    var restaurantsCellsData = [0 : [String() : String()]]
    
    func setupCellsData() {
        var howManyRestaurants = 0
        db.collection(Restaurants.identifierGroup).getDocuments { (querySnapshot, err) in
            if let err = err {
                self.state.value = .error(err.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.db.collection("Restaurants/\(document.documentID)/Branches").getDocuments { (querySnapshot, err) in
                        if let err = err {
                            self.state.value = .error(err.localizedDescription)
                        } else {
                            guard let dataName: String = data[Restaurants.Document.name] as? String,
                                  let restaurantCategory: String = data[Restaurants.category] as? String,
                                  let restaurantImage: String = data[Restaurants.image] as? String,
                                  let branch = querySnapshot!.documents[howManyRestaurants].data()[Restaurants.Document.name] as? String,
                                  let openingHours = querySnapshot!.documents[howManyRestaurants][Restaurants.Document.Branches.Document.Days.openingHours] as? [String : String],
                                  let todayOpeningHours = openingHours[self.dayOfWeek()]
                            else { return }
                            let branchID = querySnapshot!.documents[howManyRestaurants].documentID
                            
                            self.restaurantsCellsData.updateValue([Restaurants.Document.name : dataName,
                                                                   Restaurants.Document.Branches.identifier : branch,
                                                                   Restaurants.id : document.documentID,
                                                                   Restaurants.Document.Branches.id : branchID,
                                                                   Restaurants.image : restaurantImage,
                                                                   Restaurants.Document.Branches.Document.Days.openingHours : todayOpeningHours,
                                                                   Restaurants.category : restaurantCategory ],
                                                                  forKey: howManyRestaurants)
                            howManyRestaurants += 1
                            if howManyRestaurants == 1 {
                                self.state.value = .data
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func dayOfWeek() -> String {
        let f = DateFormatter()
        return f.weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1].lowercased()
    }    
}
