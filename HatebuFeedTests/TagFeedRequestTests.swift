//
//  TagFeedRequestTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
@testable import HatebuFeed

class TagFeedRequestTests: XCTestCase {
  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    self.clearRealm()

    super.tearDown()
  }

  func tagFeedRequest(tag: String = "swift") -> TagFeedRequest {
    return TagFeedRequest(tag: tag)
  }

  func testInit() {
    let request = tagFeedRequest()

    XCTAssertNotNil(request)
    XCTAssertTrue(request.dynamicType === TagFeedRequest.self)
    XCTAssertNotNil(request.category)
  }

  func testName() {
    let request = tagFeedRequest()

    XCTAssertEqual(request.name, "swift")
  }

  func testUrl() {
    let ret = tagFeedRequest().url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/search/tag")
    XCTAssertEqual(ret.params, ["q": "swift", "mode": "rss"])
  }
}
