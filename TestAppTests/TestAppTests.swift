//
//  TestAppTests.swift
//  TestAppTests
//
//

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWSPopularity(){
        do{
            let data = try Data(contentsOf: URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=bbb5045ac5f8792c20fe23b5b411cfd6")!)
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            let results = jsonDictionary?["results"] as? [NSDictionary] ?? [NSDictionary]()
            XCTAssertNotEqual(results.count, 0, "WS returns more than 0 movies")
        }catch{
            
        }
    }
    
    

}
