//
//  HotFeedRequestTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
@testable import HatebuFeed

class HotFeedRequestTests: XCTestCase {
  let hotFeed : HotFeedRequest = HotFeedRequest(name: FeedCategoryName.IT)

  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    super.tearDown()
  }

  func testInit() {
    XCTAssertNotNil(hotFeed)
    XCTAssertTrue(hotFeed.dynamicType === HotFeedRequest.self)
    XCTAssertNotNil(hotFeed.category)
  }

  func testName() {
    XCTAssertEqual(hotFeed.name, FeedCategoryName.IT.rawValue)
  }

  func testNonTotalUrl() {
    let ret = hotFeed.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/hotentry/it.rss")
    XCTAssertEqual(ret.params, [String: String]())
  }

  func testTotalUrl() {
    let feed = HotFeedRequest(name: FeedCategoryName.TOTAL)
    let ret = feed.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/hotentry")
    XCTAssertEqual(ret.params, ["mode": "rss"])
  }

  func testLoad() {
    let expectation = self.expectationWithDescription("fetch feed")

    hotFeed.load({ feedItems, error in
      for item in feedItems {
        print(item.title)
        print(item.dcDate)
      }

      expectation.fulfill()
    })

    self.waitForExpectationsWithTimeout(5.0, handler: nil)
  }
}