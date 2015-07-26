//
//  HotFeedRequestTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class HotFeedRequestTests: XCTestCase {
  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    self.clearRealm()

    super.tearDown()
  }

  private func hotFeed(name: FeedCategoryName = FeedCategoryName.IT) -> HotFeedRequest {
    return HotFeedRequest(name: name)
  }

  func testInit() {
    let feed = hotFeed()
    XCTAssertNotNil(feed)
    XCTAssertTrue(feed.dynamicType === HotFeedRequest.self)
    XCTAssertNotNil(feed.category)
  }

  func testName() {
    XCTAssertEqual(hotFeed().name, FeedCategoryName.IT.rawValue)
  }

  func testNonTotalUrl() {
    let ret = hotFeed().url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/hotentry/it.rss")
    XCTAssertEqual(ret.params, [String: String]())
  }

  func testTotalUrl() {
    let feed = hotFeed(FeedCategoryName.TOTAL)
    let ret = feed.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/hotentry")
    XCTAssertEqual(ret.params, ["mode": "rss"])
  }

  func testFeedItem_WithoutRecord() {
    let item = hotFeed().feedItem("http://example.com")
    XCTAssertNil(item)
  }

  func testFeedItem_WithRecord() {
    let realm = self.realm()

    realm.write {
      let category = FeedCategory(type: FeedCategoryType.HOT, name: FeedCategoryName.SOCIAL)
      realm.add(category)

      let item = self.sampleFeedItem("http://b.hatena.ne.jp/test")
      category.feedItems.append(item)

      realm.add(item)
    }

    let found = HotFeed(FeedCategoryName.SOCIAL).feedItem("http://b.hatena.ne.jp/test")
    XCTAssertNotNil(found)

    let notFound = HotFeed(FeedCategoryName.SOCIAL).feedItem("http://example.com")
    XCTAssertNil(notFound)
  }
}