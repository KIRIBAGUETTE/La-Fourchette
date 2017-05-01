//
//  RootRouter.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit

class RootRouter {
    
    func configWindow(window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = RestaurantsRouter.configProject()
    }
}
