//
//  Product.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 28/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Feature {
    
    var name: String?
    
    var value: String?
    
    init(json: JSON){
        
        if let name = json["name"].string {
            
            self.name = name
            
        }
        
        if let value = json["value"].string {
            
            self.value = value
            
        }
    }
    
}

struct Product {
    
    var productId: String?
    
    var title: String?
    
    var imageURL: String?
    
    var price: Price?
    
    var imageDetails: [String]?
    
    var productInformation: String?
    
    var displaySpecialOffer: String?
    
    var additionalServices: [String]?
    
    var code: String?
    
    var features: [Feature]?
    
    init(json:JSON){
        
        if let productId = json["productId"].string{
            
            self.productId = productId
            
        }
        
        if let title = json["title"].string{
            
            self.title = title
            
        }
        
        if let imageURL = json["image"].string {
            
            self.imageURL = "http:" + imageURL
            
        }

        imageDetails = []
        
        for ( _, subJson):(String, JSON) in json["media"]["images"]["urls"] {
            
            imageDetails?.append("http:" + subJson.string!)
            
        }
        
        price = Price(json: json["price"])
        
        if let productInformation = json["details"]["productInformation"].string{
            
            self.productInformation = productInformation
            
        }
        
        if let displaySpecialOffer = json["displaySpecialOffer"].string{
            
            self.displaySpecialOffer = displaySpecialOffer
            
        }
        
        additionalServices = []
        
        for ( _, subJson):(String, JSON) in json["additionalServices"]["includedServices"] {
            
            additionalServices?.append(subJson.string!)
            
        }
        
        if let code = json["code"].string {
            
            self.code = code
            
        }
        
        features = []
        
        for ( _, subJson):(String, JSON) in json["details"]["features"][0]["attributes"] {
            
            features?.append(Feature(json: subJson))
            
        }
        
        features?.sortInPlace({
            return $0.name < $1.name
        })
        
    }
    
}