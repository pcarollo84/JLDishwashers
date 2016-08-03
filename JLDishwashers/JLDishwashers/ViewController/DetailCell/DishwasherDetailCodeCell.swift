//
//  DishwasherDetailCodeCellId.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 3/08/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherDetailCodeCell: UITableViewCell {

    @IBOutlet weak var productCodeLabel: UILabel!
    
    var code: String?{
        
        didSet{
         
            updateUI()
            
        }
    }
    
    func updateUI(){
    
        guard let codeNotNil = code else {return}
        
        productCodeLabel.text = codeNotNil
        
    }
    
    
}
