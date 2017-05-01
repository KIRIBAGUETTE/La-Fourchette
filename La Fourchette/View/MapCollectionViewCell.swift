//
//  MapCollectionViewCell.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class MapCollectionViewCell: UICollectionViewCell{
    
    var map:MKMapView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        map = MKMapView(frame: frame)
        self.contentView.addSubview(map)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        map.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
