//
//  DishwasherDetailSpecificationCell.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 3/08/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherDetailSpecificationCell: UITableViewCell {

    @IBOutlet weak var featureNameLabel: UILabel!
    
    @IBOutlet weak var featureValueLabel: UILabel!
    
    var feature: Feature?{
        
        didSet{
        
            updateUI()
            
        }
        
    }
    
    func updateUI(){
        
        guard let featureNotNil = feature else {return}
        
        featureNameLabel.text = featureNotNil.name
        
        featureValueLabel.text = featureNotNil.value
        
    }
    
}
