//
//  ViewController.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 30/04/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit
import MapKit

protocol restaurantsViewProtocol: class {
    var presenter:RestaurantsPresenterDataProtocol! { get set }
    
    func showRestautantData()
    func showRestautantErrorMessage(errorMessage:String)
}

class ViewController: UIViewController, restaurantsViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Reference vers l'interface Presenter
    var presenter: RestaurantsPresenterDataProtocol!
    
    //Reference vers l'interface Entity
    var entity:RestaurantsEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.updateDataInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showRestautantData() {
        self.updateCollectionView()
        print("On affiche les informations du restaurant")
    }
    
    func showRestautantErrorMessage(errorMessage:String) {
        print("POPUP ERROR \(errorMessage)")
    }
}

