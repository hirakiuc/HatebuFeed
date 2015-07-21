//
//  UserFeedRequestTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/22.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
@testable import HatebuFeed

class UserFeedRequestTests: XCTestCase {
  let userFeed : UserFeedRequest = UserFeedRequest(userId: "hirakiuc")

  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    super.tearDown()
  }

  func testInit() {
    XCTAssertNotNil(userFeed)
    XCTAssertTrue(userFeed.dynamicType === UserFeedRequest.self)
    XCTAssertNotNil(userFeed.category)
  }

  func testName() {
    XCTAssertEqual(userFeed.name, "hirakiuc")
  }

  func testUrl() {
    let ret = userFeed.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/hirakiuc/rss")
    XCTAssertNotNil(ret.params["t"])
  }

  func testLoad() {
    let expectation = self.expectationWithDescription("fetch userFeed")

    userFeed.load { feedItems, error in
      for item in feedItems {
        print(item.title)
        print(item.dcDate)
      }

      expectation.fulfill()
    }

    self.waitForExpectationsWithTimeout(5.0, handler: nil)
  }
}
