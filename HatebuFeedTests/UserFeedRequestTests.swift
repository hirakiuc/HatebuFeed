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
  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    self.clearRealm()

    super.tearDown()
  }

  func userFeedRequest(userId: String = "hirakiuc") -> UserFeedRequest {
    return UserFeedRequest(userId: userId)
  }

  func testInit() {
    let request = self.userFeedRequest()

    XCTAssertNotNil(request)
    XCTAssertTrue(request.dynamicType === UserFeedRequest.self)
    XCTAssertNotNil(request.category)
  }

//  func testName() {
//    let request = self.userFeedRequest()
//
//    XCTAssertEqual(request.name, "hirakiuc")
//  }

//  func testUrl() {
//    let ret = self.userFeedRequest().url()
//
//    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/hirakiuc/rss")
//    XCTAssertNotNil(ret.params["t"])
//  }
}
