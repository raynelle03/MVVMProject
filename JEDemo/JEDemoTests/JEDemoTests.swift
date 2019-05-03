//
//  JEDemoTests.swift
//  JEDemoTests
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import XCTest
import Alamofire
@testable import JEDemo

class JEDemoTests: XCTestCase {

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

    func test_users_api() {
        //Test will fail if there is no internet connection
        let e = expectation(description: "Get and parse users response")
       AF.request(APIUsers.allusers)
            .responseDecodable { (response: DataResponse<[User]>) in
                switch response.result {
                case .success:
                    if response.value?.count == 0 {
                        XCTFail("No data returned")
                    }
                case .failure(let error):
                        XCTAssertNil(error, "Whoops, error \(error.localizedDescription)")
                }

                e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_posts_api() {
        //Test will fail if there is no internet connection
        let e = expectation(description: "Get and parse posts response")
         AF.request(APIPosts.allposts)
            .responseDecodable { (response: DataResponse<[Post]>) in
                switch response.result {
                case .success:
                    if response.value?.count == 0 {
                        XCTFail("No data returned")
                    }
                case .failure(let error):
                    XCTAssertNil(error, "Whoops, error \(error.localizedDescription)")
                }
                e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_comment_api_withvalid_postid() {
        //Test will fail if there is no internet connection
        let e = expectation(description: "Get and parse comments response")
        let postIdString = "2"
        AF.request(APIComments.comments(postId: postIdString))
            .responseDecodable { (response: DataResponse<[Comment]>) in
                switch response.result {
                case .success:
                    if response.value?.count == 0 {
                        XCTFail("No data returned")
                    }
                case .failure(let error):
                    XCTAssertNil(error, "Whoops, error \(error.localizedDescription)")
                }
                e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_comment_api_withInvalid_postid() {
        //Test will always fail since we pass an invalid post id
        let e = expectation(description: "Get and parse comments response")
        let postIdString = "687879"
        AF.request(APIComments.comments(postId: postIdString))
            .responseDecodable { (response: DataResponse<[Comment]>) in
                switch response.result {
                case .success:
                    if response.value?.count == 0 {
                        XCTFail("No data returned")
                    }
                case .failure(let error):
                    XCTAssertNil(error, "Whoops, error \(error.localizedDescription)")
                }
                e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    

}
