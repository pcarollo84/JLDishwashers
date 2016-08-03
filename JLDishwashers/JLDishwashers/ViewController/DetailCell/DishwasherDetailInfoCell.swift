//
//  DishwasherDetailInfoCell.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 3/08/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherDetailInfoCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: Product?{
        
        didSet{
            
            updateUI()
            
        }
    }
    
    func updateUI(){
    
        guard let productNotNil = product else {return}
        
        do{
            
            if let data = productNotNil.productInformation?.dataUsingEncoding(NSUTF8StringEncoding){
            
            let info = try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
             
                descriptionLabel.attributedText = info
            }
        }
        catch{
            
            descriptionLabel.text = "N.A"
            
        }
        
    }
    
}
