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

  func tagFeed(tag: String = "swift") -> TagFeedRequest {
    return TagFeedRequest(tag: tag)
  }

  func testInit() {
    let tagFeed = self.tagFeed()

    XCTAssertNotNil(tagFeed)
    XCTAssertTrue(tagFeed.dynamicType === TagFeedRequest.self)
    XCTAssertNotNil(tagFeed.category)
  }

  func testName() {
    let tagFeed = self.tagFeed()

    XCTAssertEqual(tagFeed.name, "swift")
  }

  func testUrl() {
    let ret = tagFeed().url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/search/tag")
    XCTAssertEqual(ret.params, ["q": "swift", "mode": "rss"])
  }

  func testFeedItem_withoutRecord() {
    let item = tagFeed().feedItem("http://example.com")
    XCTAssertNil(item)
  }

  func testFeedItem_WithRecord() {
    let realm = self.realm()

    realm.write {
      let category = FeedCategory(tag: "swift")
      realm.add(category)

      let item = self.sampleFeedItem("http://b.hatena.ne.jp/test")
      category.feedItems.append(item)

      realm.add(item)
    }

    let found = tagFeed().feedItem("http://b.hatena.ne.jp/test")
    XCTAssertNotNil(found)

    let notFound = tagFeed().feedItem("http://exapmle.com")
    XCTAssertNil(notFound)
  }
}
