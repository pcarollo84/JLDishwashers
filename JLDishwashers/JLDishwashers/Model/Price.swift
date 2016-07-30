//
//  Price.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 28/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Price{
    
    var currentValue: Double?
    
    var printablePrice: String?{
     
        get{
        
            guard let printableValue = currentValue else {return "N.A."}
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            formatter.locale = NSLocale(localeIdentifier: "en_GB")
            
            guard let printableString = formatter.stringFromNumber(printableValue) else {return "N.A."}
            
            return printableString
            
        }
        
    }
    
    init(currentValue: Double){
        
        self.currentValue = currentValue
        
    }
    
    init(json: JSON){
        
        if let currentValue = json["now"].string {
            
            let formatter = NSNumberFormatter()
            
            self.currentValue = formatter.numberFromString(currentValue)?.doubleValue
            
        }
        
    }
        
}