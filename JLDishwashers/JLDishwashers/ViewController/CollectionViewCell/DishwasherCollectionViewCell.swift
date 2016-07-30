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
        
        networkController.downloadImageWithURLString(imageURL) { (image) in
            
            guard let imageNotNil = image else {return}
            
            self.dishwasherImageView.image = imageNotNil
            
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
