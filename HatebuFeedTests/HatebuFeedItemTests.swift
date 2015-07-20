//
//  FeedItemTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class FeedItemTests: XCTestCase {
  var realm : Realm = Realm(inMemoryIdentifier: "FeedItemTestsRealm")

  override func setUp() {
    super.setUp()
    // do something
    realm.write { self.realm.deleteAll() }
  }

  override func tearDown() {
    // do something
    realm.write { self.realm.deleteAll() }
    super.tearDown()
  }

  func testSaveWithoutCategory() {
    realm.write {
      for idx in 0..<10 {
        let now = NSDate.new()

        let item = FeedItem()
        item.title = String(format: "title-%d", idx)
        item.desc = "desc"
        item.url = String(format: "http://b.hatena.ne.jp/%d", idx)
        item.hatebuCount = Int32(idx)
        item.no = Int32(idx)
        item.dcDate = now
        item.dcSubject = "some,subject"
        item.createdAt = now
        item.updatedAt = now
        
        self.realm.add(item)
      }
    }

    XCTAssertEqual(realm.objects(FeedItem).count, 10)
  }

  func testSaveWithCategory() {
    realm.write {
      let category = FeedCategory()
      category.type = FeedCategoryType.HOT.rawValue
      category.name = FeedCategoryName.IT.rawValue

      self.realm.add(category)

      let now = NSDate.new()
      let item = FeedItem()
      item.title = "test-title"
      item.desc = "description"
      item.url = "http://b.hatena.ne.jp/test"
      item.hatebuCount = Int32(10)
      item.no = Int32(0)
      item.dcDate = now
      item.dcSubject = "subjectA"
      item.createdAt = now
      item.updatedAt = now
      category.feedItems.append(item)

      self.realm.add(item)
    }

    let feedItems = realm.objects(FeedItem).filter("url = %@", "http://b.hatena.ne.jp/test")
    XCTAssertEqual(feedItems.count, 1)
    let item = feedItems[0]
    XCTAssertEqual(item.url, "http://b.hatena.ne.jp/test")
  }
}
