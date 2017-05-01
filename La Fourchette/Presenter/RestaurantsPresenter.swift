//
//  RestaurantPresenter.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import Foundation

// Protocol de View à Presenter

protocol RestaurantsPresenterViewProtocol: class {
    func updateRestaurantView()
    func errorRestaurantView(errorMessage:String)
}

// Protocol d'Interactor à Presenter

protocol RestaurantsPresenterDataProtocol: class {
    func updateDataInformation()
}

class RestaurantsPresenter: RestaurantsPresenterViewProtocol, RestaurantsPresenterDataProtocol {
    //Reference vers l'interface interactor
    var interactor:RestaurantsInteractorProtocol!
    
    //Reference vers l'interface View
    var view:restaurantsViewProtocol!
    
    //Reference vers l'interface Router
    var router:RestaurantsRouterProtocol!
    
    //Reference vers l'interface Entity
    var entity:RestaurantsEntity!
    
    func updateDataInformation() {
        print("DATAS : UPDATE")
        self.interactor.updateList()
    }
    
    func updateRestaurantView() {
        print("VIEW : UPDATE")
        self.view.showRestautantData()
    }
    
    func errorRestaurantView(errorMessage:String) {
        self.view.showRestautantErrorMessage(errorMessage:errorMessage)
    }
    
}
