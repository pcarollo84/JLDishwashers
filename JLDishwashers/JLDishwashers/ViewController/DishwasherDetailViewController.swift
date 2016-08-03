//
//  DishwasherDetailViewController.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 3/08/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherDetailViewController: UIViewController {
 
    var product: Product?
    
    @IBOutlet weak var productDetailTableView: UITableView!
    
    @IBOutlet weak var productDetailPriceContainerView: UIView!
    
    @IBOutlet weak var productDetailPriceContainerViewWidthLayoutConstraint: NSLayoutConstraint!
    
    //MARK: UITableView Datasource

    override func viewDidLoad() {
        
        let netWorkController = NetworkController()
        
        guard let productNotNil = product,  productId = productNotNil.productId else { return }
        
        netWorkController.productDetail(productId) { (result) in
            
        }
        
    }
    
}
