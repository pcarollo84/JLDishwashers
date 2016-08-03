//
//  DishwasherDetailPriceViewController.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 3/08/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherDetailPriceViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var specialOfferLabel: UILabel!
    
    var product: Product?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        specialOfferLabel.textColor = UIColor.specialOfferColor()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        guard let productNotNil = product, priceNotNil = productNotNil.price else {return}
        
        priceLabel.text = priceNotNil.printablePrice
        
        specialOfferLabel.text = productNotNil.displaySpecialOffer

        
    }
    
}
