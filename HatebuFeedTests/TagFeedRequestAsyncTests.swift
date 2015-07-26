//
//  TagFeedRequestAsyncTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/26.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class TagFeedRequestAsyncTests: XCTestCase {
  override func setUp() {
    super.setUp()
    // do something

    self.clearRealm()
  }

  override func tearDown() {
    // do something
    self.clearRealm()

    super.tearDown()
  }

  func testLoad() {
    let expectation = self.expectationWithDescription("fetch feed")
    let request = TagFeedRequest(tag: "swift")

    request.load { feedItems, error in

      for item in feedItems {
        print(item.title)
        print(item.dcDate)
      }

      expectation.fulfill()
    }

    self.waitForExpectationsWithTimeout(5.0) { (error) -> Void in
      let realm = self.realm()

      let category = realm.objectForPrimaryKey(FeedCategory.self, key: request.category.uid)!
      let count = realm.objects(FeedItem).count

      XCTAssertEqual(category.feedItems.count, count)

      self.clearRealm()
    }
  }
}