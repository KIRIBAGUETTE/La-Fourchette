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
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
            cell.backgroundColor = UIColor.red
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
            cell.backgroundColor = UIColor.orange
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! MapCollectionViewCell
            let location = CLLocationCoordinate2D(latitude: self.entity.gps_lat, longitude: self.entity.gps_long)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            cell.map.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = self.entity.name
            annotation.subtitle = self.entity.address + " " + self.entity.zipcode + " " + self.entity.city
            cell.map.addAnnotation(annotation)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            let size:CGSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 40 / 100)
            return size
        } else if indexPath.row == 1 {
            let size:CGSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 30 / 100)
            return size
        } else {
            let size:CGSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 60 / 100)
            return size
        }
    }
    
    func updateCollectionView() {
        var collectionView: UICollectionView!
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       // layout.itemSize = CGSize(width: self.view.bounds.width, height: 120)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
    
    func showRestautantData() {
        self.updateCollectionView()
        print("On affiche les informations du restaurant")
    }
    
    func showRestautantErrorMessage(errorMessage:String) {
        print("POPUP ERROR \(errorMessage)")
    }


}

