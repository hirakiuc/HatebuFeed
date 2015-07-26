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

  func userFeed(userId: String = "hirakiuc") -> UserFeedRequest {
    return UserFeedRequest(userId: userId)
  }

  func testInit() {
    let userFeed = self.userFeed()

    XCTAssertNotNil(userFeed)
    XCTAssertTrue(userFeed.dynamicType === UserFeedRequest.self)
    XCTAssertNotNil(userFeed.category)
  }

  func testName() {
    let userFeed = self.userFeed()

    XCTAssertEqual(userFeed.name, "hirakiuc")
  }

  func testUrl() {
    let ret = self.userFeed().url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/hirakiuc/rss")
    XCTAssertNotNil(ret.params["t"])
  }

  func testFeedItem_WithoutRecord() {
    let item = userFeed().feedItem("http://example.com")
    XCTAssertNil(item)
  }

  func testFeedItem_WithRecord() {
    let realm = self.realm()

    realm.write {
      let category = FeedCategory(userId: "hirakiuc")
      realm.add(category)

      let item = self.sampleFeedItem("http://b.hatena.ne.jp/test")
      category.feedItems.append(item)

      realm.add(item)
    }

    let found = userFeed().feedItem("http://b.hatena.ne.jp/test")
    XCTAssertNotNil(found)

    let notFound = userFeed().feedItem("http://example.com")
    XCTAssertNil(notFound)
  }
}
