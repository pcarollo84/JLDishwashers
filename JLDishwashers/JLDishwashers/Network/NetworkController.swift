//
//  NetworkController.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 29/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkController {
    
    func listOfDishwashers(completion: (result: [Product]?) -> Void)  {
        
        let url = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20"
     
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var productsToReturn = [Product]()
                    
                    if let productsArray = json["products"].array {
                        
                        for subJson in productsArray {
                            //Do something you want
                            
                            let product = Product(json: subJson)
                            
                            productsToReturn.append(product)
                            
                        }
                        
                    }
                    
                    completion(result: productsToReturn)
                    
                }
            case .Failure(let error):
                print(error)
                
                completion(result: nil)
                
            }
        }
        
    }
    
}