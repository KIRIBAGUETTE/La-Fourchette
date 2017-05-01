//
//  RestaurantsRouter.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit

protocol RestaurantsRouterProtocol:class {
    
}

class RestaurantsRouter: RestaurantsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func configProject() -> UIViewController {
        
        let view = ViewController()
        let presenter = RestaurantsPresenter()
        let interactor = RestaurantsInteractor()
        let router = RestaurantsRouter()
        let entity = RestaurantsEntity()
        
        view.presenter = presenter
        view.entity = entity
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.entity = entity
        interactor.presenter = presenter
        interactor.entity = entity
        router.viewController = view
        return view
    }
}
