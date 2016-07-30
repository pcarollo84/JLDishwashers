//
//  NetworkTestCase.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 30/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class NetworkTestCase: XCTestCase {

    let networkController = NetworkController()
    
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
        
        testDishwasherList()
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDishwasherList(){
        
        let getExpectation = self.expectationWithDescription("GET have a list of dishwashers")
        
        networkController.listOfDishwashers({
            
            (result: [Product]?) in

            XCTAssertNotNil(result)
            
            getExpectation.fulfill()
            
        })
        
        
        self.waitForExpectationsWithTimeout(3) { (error: NSError?) in
            
            //best would be to cancel the get operation
            //in the case the get take too long
            
        }
        
    }


}
