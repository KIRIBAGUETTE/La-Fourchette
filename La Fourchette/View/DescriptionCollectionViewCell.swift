//
//  DescriptionCollectionViewCell.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 02/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    
    var Name:UILabel!
    var Address:UILabel!
    var Average:UILabel!
    var Avis:UILabel!
    var Cost:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Name = UILabel()
        Name.font = UIFont(name: "HelveticaNeue-bold", size: 27)
        Name.textColor = UIColor.black
        self.contentView.addSubview(Name)

        Address = UILabel()
        Address.font = UIFont(name: "HelveticaNeue", size: 16)
        Address.textColor = UIColor.gray
        self.contentView.addSubview(Address)
        
        Average = UILabel()
        Average.font = UIFont(name: "HelveticaNeue-bold", size: 25)
        Average.textColor = UIColor.black
        self.contentView.addSubview(Average)
        
        Avis = UILabel()
        Avis.font = UIFont(name: "HelveticaNeue", size: 15)
        Avis.textColor = UIColor.gray
        self.contentView.addSubview(Avis)
        
        Cost = UILabel()
        Cost.font = UIFont(name: "HelveticaNeue", size: 17)
        Cost.textColor = UIColor.black
        self.contentView.addSubview(Cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Name.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalToSuperview()
        }
        
        Address.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(Name.snp.bottom).offset(10)
        }
        
        Average.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        Avis.snp.makeConstraints { (make) in
            make.centerX.equalTo(Average.snp.centerX)
            make.top.equalTo(Average.snp.bottom)
        }
        
        Cost.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            
        }
    }
}
