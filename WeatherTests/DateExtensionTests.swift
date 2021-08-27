//
//  DateExtensionTests.swift
//  WeatherTests
//
//  Created by MAC on 27/08/21.
//

import XCTest
@testable import Weather

class DateExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getDatefromMilliSeaconds() {
       let dayDate  =  Date.getDate(milliSec:1629972000, format:Constatns.dayDateFormat )
        
        XCTAssertEqual(dayDate, "Thursday-08/26/2021")
        let hrDate  =  Date.getDate(milliSec:1629972000, format:Constatns.hourlyDateFormat )
        
        XCTAssertEqual(hrDate, "03:30")


    }
}
