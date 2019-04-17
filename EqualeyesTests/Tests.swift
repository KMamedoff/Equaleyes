//
//  Tests.swift
//  EqualeyesTests
//
//  Created by Kenan Mamedoff on 17/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import XCTest
@testable import Equaleyes

class Tests: XCTestCase {

    func testNetworkingService() {
        let exp = expectation(description: "Request")
        
        let teacherUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers"
        NetworkingService.shared.fetchData(urlString: teacherUrl) { (posts: [Teacher]) in
            XCTAssertNotNil(posts)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
