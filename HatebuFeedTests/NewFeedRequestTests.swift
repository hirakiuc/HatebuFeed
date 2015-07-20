//
//  NewFeedRequestTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
@testable import HatebuFeed

class NewFeedRequestTests: XCTestCase {
  let newFeed : NewFeedRequest = NewFeedRequest(name: FeedCategoryName.SOCIAL)

  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    super.tearDown()
  }

  func testInit() {
    XCTAssertNotNil(newFeed)
    XCTAssertTrue(newFeed.dynamicType === NewFeedRequest.self)
    XCTAssertNotNil(newFeed.category)
  }

  func testName() {
    XCTAssertEqual(newFeed.name, FeedCategoryName.SOCIAL.rawValue)
  }

  func testNonTotalUrl() {
    let ret = newFeed.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/entrylist/social")
    XCTAssertEqual(ret.params, ["mode": "rss"])
  }

  func testTotalURL() {
    let feed = NewFeedRequest(name: FeedCategoryName.TOTAL)
    let ret = feed.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/entrylist")
    XCTAssertEqual(ret.params, ["mode": "rss"])
  }

  func testLoad() {
    let expectation = self.expectationWithDescription("fetch feed")

    newFeed.load({ feedItems, error in
      for item in feedItems {
        print(item.title)
        print(item.dcDate)
      }

      expectation.fulfill()
    })

    self.waitForExpectationsWithTimeout(5.0, handler: nil)
  }
}
