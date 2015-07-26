//
//  NewFeedRequestTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class NewFeedRequestTests: XCTestCase {
  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    self.clearRealm()

    super.tearDown()
  }

  func newFeed(name: FeedCategoryName = FeedCategoryName.SOCIAL) -> NewFeedRequest {
    return NewFeedRequest(name: name)
  }

  func testInit() {
    let request = self.newFeed()

    XCTAssertNotNil(request)
    XCTAssertTrue(request.dynamicType === NewFeedRequest.self)
    XCTAssertNotNil(request.category)
  }

  func testName() {
    let request = self.newFeed()

    XCTAssertEqual(request.name, FeedCategoryName.SOCIAL.rawValue)
  }

  func testNonTotalUrl() {
    let request = self.newFeed()
    let ret = request.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/entrylist/social")
    XCTAssertEqual(ret.params, ["mode": "rss"])
  }

  func testTotalURL() {
    let request = NewFeedRequest(name: FeedCategoryName.TOTAL)
    let ret = request.url()

    XCTAssertEqual(ret.url, "http://b.hatena.ne.jp/entrylist")
    XCTAssertEqual(ret.params, ["mode": "rss"])
  }
}
