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
  static let tagName : String = "swift"
  let tagFeed : TagFeedRequest = TagFeedRequest(tag: tagName)

  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    super.tearDown()
  }

  func testInit() {
    XCTAssertNotNil(tagFeed)
    XCTAssertTrue(tagFeed.dynamicType === TagFeedRequest.self)
    XCTAssertNotNil(tagFeed.category)
  }

  func testName() {
    XCTAssertEqual(tagFeed.name, TagFeedRequestTests.tagName)
  }

  func testUrl() {
    let ret = tagFeed.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/search/tag")
    XCTAssertEqual(ret.params, ["q": TagFeedRequestTests.tagName, "mode": "rss"])
  }

  func testLoad() {
    let expectation = self.expectationWithDescription("fetch feed")

    tagFeed.load { feedItems, error in

      for item in feedItems {
        print(item.title)
        print(item.dcDate)
      }

      expectation.fulfill()
    }

    self.waitForExpectationsWithTimeout(5.0, handler: nil)
  }
}
