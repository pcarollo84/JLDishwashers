//
//  DishwasherCollectionViewController.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 29/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {

        let netWorkController = NetworkController()
        
        netWorkController.listOfDishwashers({
            
            (result: [Product]?) in
            
            for product in result!{
                
                print(product.productId)
                
            }
            
        })
        
    }
    
}
