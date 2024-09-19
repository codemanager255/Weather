//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Mac on 13/09/24.
//

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKelvinToCelcius() throws {
        let nm = ApiCall()
        let weatherVM = WeatherViewModel(networkManager: nm)
        let celcius = weatherVM.kelvinToCelcius(kelvin: 0)
        XCTAssert(celcius == -273)
    }
    
    func testKelvinToCelcius2() throws {
        let nm = ApiCall()
        let weatherVM = WeatherViewModel(networkManager: nm)
        let celcius = weatherVM.kelvinToCelcius(kelvin: 0)
        XCTAssert(celcius == -273)
    }
    
    func testKelvinToFarenheit() throws {
        let nm = ApiCall()
        let weatherVM = WeatherViewModel(networkManager: nm)
        let farenheit = weatherVM.kelvinToFarenheit(kelvin: 0)
        print(farenheit)
        XCTAssert(farenheit == -459)
    }
    
    func testKelvinToFarenheit2() throws {
        let nm = ApiCall()
        let weatherVM = WeatherViewModel(networkManager: nm)
        let farenheit = weatherVM.kelvinToFarenheit(kelvin: 255)
        print(farenheit)
        XCTAssert(farenheit == 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
