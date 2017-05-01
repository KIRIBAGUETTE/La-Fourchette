//
//  PictureCollectionViewCell.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit
import SnapKit

class PictureCollectionViewCell : UICollectionViewCell {
    
    var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView()
        image.image = UIImage(named: "")
        self.contentView.addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
