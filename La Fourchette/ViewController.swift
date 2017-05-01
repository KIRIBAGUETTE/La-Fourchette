//
//  ViewController.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 30/04/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit

protocol restaurantsViewProtocol: class {
    var presenter:RestaurantsPresenterDataProtocol! { get set }
    
    func showRestautantData()
    func showRestautantErrorMessage(errorMessage:String)
}

class ViewController: UIViewController, restaurantsViewProtocol {

    // Reference vers l'interface Presenter
    var presenter: RestaurantsPresenterDataProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.updateDataInformation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showRestautantData() {
        print("On affiche les informations du restaurant")
    }
    
    func showRestautantErrorMessage(errorMessage:String) {
        print("POPUP ERROR \(errorMessage)")
    }


}

