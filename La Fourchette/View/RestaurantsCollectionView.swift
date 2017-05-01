//
//  RestaurantsCollectionView.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 02/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit
import MapKit

extension ViewController {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PictureCollectionViewCell
            cell.imageView.image = self.entity.picture
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "descriptionCell", for: indexPath) as! DescriptionCollectionViewCell
            cell.Name.text = self.entity.name
            cell.Address.text = self.entity.address + " " + self.entity.zipcode + " " + self.entity.city
            cell.Average.text = String(self.entity.avg_rate) + "/10"
            cell.Avis.text = String(self.entity.rate_count) + " avis sur LaFourchette"
            cell.Cost.text = "Prix moyen à la carte de ce restaurant : 24€"
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
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

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: "descriptionCell")
        collectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
}
