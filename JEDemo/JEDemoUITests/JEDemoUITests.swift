//
//  JEDemoUITests.swift
//  JEDemoUITests
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import XCTest

class JEDemoUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func test_user_posts_and_comments() {
         //This test will fail if there is no internet connection and there is no data in the cache/Database.

        //launch home screen (Posts screen)
        XCTAssertTrue(XCUIApplication().otherElements["Posts"].exists)
        let delayExpectation = expectation(description: "Waiting for cells to appear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            delayExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(XCUIApplication().tables.cells.count > 0)
        let postTable = XCUIApplication().tables.matching(identifier: "PostsTableView")
        if postTable.cells.count == 0 {
          XCTFail("Invalid code entered. No restaurants will be displayed")
        }
        let cell = XCUIApplication().tables.cells.element(matching: .cell, identifier: "myCell_0")
        cell.tap()

        //Move to comment screen
        XCTAssertTrue(XCUIApplication().otherElements["Comments"].exists)
        let delayExpectationComments = expectation(description: "Waiting for cells to appear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            delayExpectationComments.fulfill()
        }
        waitForExpectations(timeout: 5)
        let commentTable = XCUIApplication().tables.matching(identifier: "CommentsTableView")
        XCTAssertTrue(commentTable.cells.count > 0)
    }

}
