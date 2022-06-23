//
//  SpaceAppTests.swift
//  SpaceAppTests
//
//  Created by 庄子優太 on 2022/06/20.
//

//テスト対象をインポートする（クラスではない）
import XCTest
//
@testable import SpaceApp

class SpaceAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssertEqual(10, 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
