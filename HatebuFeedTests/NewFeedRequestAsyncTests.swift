//
//  NewFeedRequestAsyncTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/26.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class NewFeedRequestAsyncTests: XCTestCase {
  override func setUp() {
    super.setUp()

    // do something
    self.clearRealm()
  }

  override func tearDown() {
    // do something
    super.tearDown()
  }

  func testFetch() {
    let expectation = self.expectationWithDescription("fetch new feed")

    let newFeed = NewFeedRequest(name: FeedCategoryName.IT)

    newFeed.fetch { (feedItems, error) -> Void in
      for item in feedItems {
        print(item.title)
        print(item.dcDate)
      }

      expectation.fulfill()
    }

    self.waitForExpectationsWithTimeout(5.0) { (error) -> Void in
      let realm = self.realm()

      let category = realm.objectForPrimaryKey(FeedCategory.self, key: newFeed.category.uid)!
      let count = realm.objects(FeedItem).count

      XCTAssertEqual(category.feedItems.count, count)

      self.clearRealm()
    }
  }
}
