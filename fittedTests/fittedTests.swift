//
//  fittedTests.swift
//  fittedTests
//
//  Created by Yannick Lawler on 20.11.20.
//

import XCTest
@testable import fitted

class fittedTests: XCTestCase {
    
    let CDM = CoreDataManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - CoreDataManager Tests
    func testCoreDataManagerMoodExpansion() throws {
        // Expand Moods array
        let MoodTestArray: [Mood] = [Work, Bloated, Fancy]
        let expandedMoodsResult = "Work,Bloated,Fancy"
        let expandedMoods = CDM.expandMoods(array: MoodTestArray)
        XCTAssertEqual(expandedMoods, expandedMoodsResult)
    }
    
    func testCoreDataManagerWeatherExpansion() throws {
        // Expand Weathers array
        let WeatherTestArray: [Weather] = [Sunny, Rainy, Cloudy]
        let expandedWeathersResult = "Sunny,Rainy,Cloudy"
        let expandedWeathers = CDM.expandWeathers(array: WeatherTestArray)
        XCTAssertEqual(expandedWeathers, expandedWeathersResult)
    }
    
    
    
    

}
