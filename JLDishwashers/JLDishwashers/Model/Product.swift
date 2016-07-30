//
//  Product.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 28/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Product {
    
    var productId: String?
    
    var title: String?
    
    var imageURL: String?
    
    var price: Price?
    
    init(json:JSON){
        
        if let productId = json["productId"].string{
            
            self.productId = productId
            
        }
        
        if let title = json["title"].string{
            
            self.title = title
            
        }
        
        if let imageURL = json["image"].string {
            
            self.imageURL = imageURL
            
        }
        
        price = Price(json: json["price"])
        
    }
    
}