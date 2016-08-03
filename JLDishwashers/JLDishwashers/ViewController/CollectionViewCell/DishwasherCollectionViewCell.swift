//
//  DishwasherCollectionViewCell.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 30/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dishwasherImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    let networkController = NetworkController()
    
    var product: Product?{
        
        didSet{
        
            updateUI()
            
        }
        
    }
    
    
    func updateUI(){

        updateImage()
        
        updateDescription()
        
        updatePrice()
    }

    func updateImage(){
        
        guard let productNotNil = self.product else {return}
        
        guard let imageURL = productNotNil.imageURL else {return}
        
        dishwasherImageView.alpha = 0
        
        networkController.downloadImageWithURLString(imageURL) { (image) in
            
            guard let imageNotNil = image else {return}
            
            let newImage = imageNotNil.af_imageScaledToSize(CGSize(width: 100, height: 100))
            
            self.dishwasherImageView.image = newImage
            
            UIView.animateWithDuration(0.25, animations: { 
                
                self.dishwasherImageView.alpha = 1.0
                
            })
            
        }

    }

    func updateDescription(){
        
        guard let productNotNil = self.product else {return}

        self.descriptionLabel.text = productNotNil.title
        
    }

    func updatePrice(){
        
        guard let productNotNil = self.product else {return}
        
        guard let priceNotNil = productNotNil.price else {
            
            self.priceLabel.text = "N.A."
            
            return
        }
        
        self.priceLabel.text = priceNotNil.printablePrice
        
    }
    
}
