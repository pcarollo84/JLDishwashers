//
//  ModelTestCase.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 28/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import XCTest

@testable import JLDishwashers

class ModelTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //Testing if the currency is correctly shown
        let testPrice = Price(currentValue: 42.76)
        XCTAssertEqual(testPrice.printablePrice, "£42.76")
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
